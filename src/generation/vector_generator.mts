import {
	RustFunctionArgument,
	RustPrimitive,
	RustPrimitiveWrapper,
	RustResult,
	RustStruct,
	RustTaggedValueEnum,
	RustTuple,
	RustType,
	RustVector
} from '../rust_types.mjs';
import {BaseTypeGenerator} from './base_type_generator.mjs';

export default class VectorGenerator extends BaseTypeGenerator<RustVector> {

	generateFileContents(type: RustVector): string {
		const swiftTypeName = this.swiftTypeName(type);

		let generatedMethods = '';
		for (const currentMethod of type.methods) {
			generatedMethods += this.generateMethod(currentMethod, type);
		}

		// this type is elided
		const swiftPublicType = this.getPublicTypeSignature(type);

		let dataContainerInitializationArgumentName = 'rustArray';
		let dimensionalityReduction = '';

		/**
		 * Necessary for init() methods that take a Swift array
		 */
		let swiftArrayToRustArrayMapper = '';

		/**
		 * Necessary for getValue() calls that need to produce a Swift array
		 */
		let rustArrayToSwiftArrayMapper = '';

		/**
		 * If the deepest type is not a primitive, a Rust->Swift mapper is definitely necessary,
		 * and a Swift->Rust mapper is potentially necessary
		 */
		if(!(type.deepestIterateeType instanceof RustPrimitive)){
			// we'll need to map the Rust types to Swift types because they're not primitive
			rustArrayToSwiftArrayMapper = 'let swiftArray = array.map { (currentCType) in\n'

			let unwrapperSuffix = '';
			let depth = 1;
			const artificialDeepestContext = new RustFunctionArgument();
			artificialDeepestContext.contextualName = 'currentValueDepth'+depth;
			artificialDeepestContext.type = type.deepestIterateeType;

			if(type.iterateeField.type instanceof RustVector){
				let currentIteratee: RustType = type.iterateeField.type;
				while (currentIteratee instanceof RustVector) {
					const indentationDepth = 6 + depth;
					const indentation = `\t`.repeat(indentationDepth);

					rustArrayToSwiftArrayMapper += `${indentation}currentCType.map { (currentCType) in\n`;
					unwrapperSuffix += `\n${indentation}}`;

					currentIteratee = currentIteratee.iterateeField.type;
					depth++;
				}
			} else {
				// additionally, if the top level iteratee is not a rust vector, a Swift->Rust mapper is necessary
				// (if it is a vector, a corresponding underlying vector can be trivially initiated)
				const deepestRustValueUnwrapper = this.prepareSwiftArgumentForRust(artificialDeepestContext, type);
				swiftArrayToRustArrayMapper = `
						let rustArray = array.map { (currentValueDepth1) in
							${deepestRustValueUnwrapper.conversion}
							return ${deepestRustValueUnwrapper.methodCallWrapperPrefix}${deepestRustValueUnwrapper.accessor}${deepestRustValueUnwrapper.methodCallWrapperSuffix}
						}
				`;
			}

			artificialDeepestContext.contextualName = 'currentValueDepth'+depth;
			const deepestSwiftReturnValueWrapper = this.prepareRustReturnValueForSwift(artificialDeepestContext, type);
			let deepestConstructor = `${deepestSwiftReturnValueWrapper.wrapperPrefix}currentCType${deepestSwiftReturnValueWrapper.wrapperSuffix}`;

			unwrapperSuffix += '\n' + '\t'.repeat(6) + '}';
			rustArrayToSwiftArrayMapper += `${deepestConstructor}${unwrapperSuffix}`;
		} else {
			rustArrayToSwiftArrayMapper = 'let swiftArray = array'
		}

		let bracketedIterateeTypeName = null;
		if (type.iterateeField.type instanceof RustVector) {
			const iterateeRustTypeName = type.iterateeField.type.name;
			bracketedIterateeTypeName = '<' + iterateeRustTypeName + '>';

			// avoid elision
			const iterateeSwiftTypeName = this.getPublicTypeSignature(type.iterateeField.type, type.iterateeField.type);

			dimensionalityReduction = `
						var lowerDimension = [${iterateeRustTypeName}]()
						for currentEntry in array {
							let convertedEntry = ${iterateeSwiftTypeName}(array: currentEntry)
							lowerDimension.append(convertedEntry.cType!)
							try! self.addAnchor(anchor: convertedEntry)
						}
			`;
			dataContainerInitializationArgumentName = 'lowerDimension';

		} else if (type.iterateeField.type instanceof RustPrimitive) {
			bracketedIterateeTypeName = `<${type.iterateeField.type.swiftRawSignature}>`;
			dataContainerInitializationArgumentName = 'array';
		}else if (type.iterateeField.type instanceof RustTuple || type.iterateeField.type instanceof RustPrimitiveWrapper || type.iterateeField.type instanceof RustTaggedValueEnum || type.iterateeField.type instanceof RustResult || type.iterateeField.type instanceof RustStruct) {
			bracketedIterateeTypeName = `<${type.iterateeField.type.name}>`;
		} else {
			throw new Error(`Unsupported vector iteratee type in ${type.name}: ${type.iterateeField.type.getName()} (${type.iterateeField.type.constructor.name})`);
		}

		if (!bracketedIterateeTypeName) {
			throw new Error(`Undetected vector iteratee type name in ${type.name}: ${type.iterateeField.type.getName()} (${type.iterateeField.type.constructor.name})`);
		}

		return `
			#if SWIFT_PACKAGE
			import LDKHeaders
			#endif

			internal typealias ${swiftTypeName} = Bindings.${swiftTypeName}

			extension Bindings {

				${this.renderDocComment(type.documentation, 4)}
				internal class ${swiftTypeName}: NativeTypeWrapper {

					${this.inheritedInits(type)}

					public init(array: ${swiftPublicType}) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						super.init(conflictAvoidingVariableName: 0)

						${swiftArrayToRustArrayMapper}

						${dimensionalityReduction}

						let dataContainer = UnsafeMutablePointer${bracketedIterateeTypeName}.allocate(capacity: array.count)
						dataContainer.initialize(from: ${dataContainerInitializationArgumentName}, count: array.count)

        				let vector = ${type.name}(data: dataContainer, datalen: UInt(array.count))
        				self.cType = vector
					}

					public func getValue() -> ${swiftPublicType} {

						var array = ${this.getRustArrayTypeSignature(type)}()

						${this.valueAccessCode(type)}

						${rustArrayToSwiftArrayMapper}
						return swiftArray
					}

					${generatedMethods}

					internal func dangle() -> ${swiftTypeName} {
        				self.dangling = true
						return self
					}

					${this.renderDanglingCloneAndDeinitMethods(type)}

				}

			}
		`;
	}

	outputDirectorySuffix(): string {
		return 'vectors';
	}

	private valueAccessCode(type: RustVector, depth = 1) {

		const additionalIndentation = '\t'.repeat(depth - 1);

		let higherLevelArrayName = `convertedEntry${depth - 1}`;
		let higherLevelAccessor = `currentEntry${depth - 1}`;
		if (depth === 1) {
			higherLevelArrayName = 'array';
			higherLevelAccessor = 'self.cType!';
		}

		let termination = `${additionalIndentation}${higherLevelArrayName}.append(currentEntry${depth})`;

		if (type.iterateeField.type instanceof RustVector) {
			// it's nested
			termination = `
							${additionalIndentation}var convertedEntry${depth} = ${this.getRustArrayTypeSignature(type.iterateeField.type)}()

							${this.valueAccessCode(type.iterateeField.type, depth + 1)}

							${additionalIndentation}${higherLevelArrayName}.append(convertedEntry${depth})
			`;
		}

		return `
						${additionalIndentation}for index${depth} in 0..<Int(${higherLevelAccessor}.datalen) {
							${additionalIndentation}let currentEntry${depth} = ${higherLevelAccessor}.data[index${depth}]
							${termination}
						${additionalIndentation}}
		`;
	}

	private getRustArrayTypeSignature(type: RustType): string {
		if (type instanceof RustVector) {
			return `[${this.getRustArrayTypeSignature(type.iterateeField.type)}]`;
		} else if (type instanceof RustPrimitive) {
			return type.swiftRawSignature;
		}
		const typeName = type.getName();
		if (!typeName) {
			throw new Error('Unnamed type of kind ' + type.constructor.name);
		}
		return typeName;
	}

}