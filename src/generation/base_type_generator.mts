import Config from '../config.mjs';
import {
	ContextualRustType,
	OpaqueRustStruct,
	RustArray,
	RustFunction,
	RustFunctionArgument,
	RustFunctionReturnValue,
	RustLambda,
	RustNullableOption,
	RustPrimitive,
	RustPrimitiveEnum,
	RustPrimitiveWrapper,
	RustResult,
	RustStruct,
	RustStructField,
	RustTaggedValueEnum,
	RustTrait,
	RustTuple,
	RustType,
	RustVector
} from '../rust_types.mjs';
import * as path from 'path';
import * as fs from 'fs';
import Generator, {AuxiliaryArtifacts} from './index.mjs';

/**
 * Generates just one individual type. Each kind has its own implementation.
 */
export abstract class BaseTypeGenerator<Type extends RustType> {

	protected config: Config;
	protected auxiliaryArtifacts: AuxiliaryArtifacts;

	constructor(config: Config, auxiliaryArtifacts: AuxiliaryArtifacts) {
		this.config = config;
		this.auxiliaryArtifacts = auxiliaryArtifacts;
	}

	/**
	 *
	 * @param type
	 */
	generate(type: Type) {
		const fileContents = this.generateFileContents(type);
		this.persist(type, fileContents);
	}

	/**
	 *
	 * @param type
	 */
	abstract generateFileContents(type: Type): string;

	protected abstract outputDirectorySuffix(): string;

	protected swiftTypeName(type: RustType): string {
		if (type instanceof RustPrimitive) {
			return type.swiftRawSignature;
		}
		const typeName = type.getName();
		if (typeName && typeName.startsWith('LDK')) {
			const ldkLessTypeName = typeName.substring('LDK'.length);
			if (ldkLessTypeName.charAt(0) === 'C') {
				if (ldkLessTypeName.startsWith('C2Tuple_') || ldkLessTypeName.startsWith('C3Tuple_')) {
					return ldkLessTypeName.substring(2);
				}

				const secondCharacter = ldkLessTypeName.charAt(1);
				if (secondCharacter === secondCharacter.toUpperCase()) {
					// it's probably an LDKCVec or LDKCResult or something like that
					return ldkLessTypeName.substring(1);
				}

			}

			// an exception due to Swift reserved keywords
			if (ldkLessTypeName === 'Type') {
				return 'BindingsType';
			} else if (ldkLessTypeName === 'Error') {
				return 'BindingsError';
			}

			return ldkLessTypeName;
		}
		throw new Error('Rust type names should always start with LDK');
	}

	protected hasFreeMethod(type: RustType): boolean {
		return this.hasMethod(type, 'free');
	}

	protected hasCloneMethod(type: RustType): boolean {
		return this.hasMethod(type, 'clone');
	}

	protected persist(type: RustType, fileContents: string) {
		const outputPath = this.outputFilePath(type);
		const outputDirectory = path.dirname(outputPath);
		fs.mkdirSync(outputDirectory, {recursive: true});
		fs.writeFileSync(outputPath, fileContents, {});
	}

	protected generateAccessor(field: RustStructField, containerType: RustType): string {
		if (field.type instanceof OpaqueRustStruct) {
			// this should not be exposed
			return '';
		}

		let accessorName = 'get' + Generator.snakeCaseToCamelCase(field.contextualName, true);
		if (field.contextualName.startsWith('is') && field.type instanceof RustPrimitive && field.type.swiftRawSignature === 'Bool') {
			// this is just a flag
			accessorName = Generator.snakeCaseToCamelCase(field.contextualName);
		}

		const swiftReturnType = this.getPublicTypeSignature(field.type);
		const fieldAccessor = `self.cType!.${field.contextualName}`;
		const preparedReturnValue = this.prepareRustReturnValueForSwift(field);

		return `
					${this.renderDocComment(field.documentation, 5)}
					public func ${accessorName}() -> ${swiftReturnType} {
						// return value (do some wrapping)
						let returnValue = ${preparedReturnValue.wrapperPrefix}${fieldAccessor}${preparedReturnValue.wrapperSuffix}

						return returnValue;
					}
		`;
	}

	protected generateMethod(method: RustFunction, containerType?: RustType): string {

		const swiftMethodName = this.swiftMethodName(method, containerType);
		let swiftMethodArguments = [];
		let nativeCallValueAccessors = [];
		let isInstanceMethod = false;

		let nativeCallPrefix = '';
		let nativeCallWrapperPrefix = '', nativeCallWrapperSuffix = '';
		let nativeCallSuffix = '';

		for (const currentArgument of method.arguments) {
			if (currentArgument.type instanceof RustPrimitive) {
				if (currentArgument.type.swiftRawSignature === 'Void' && !currentArgument.contextualName) {
					// this is an absolutely wild exception where an argument is unnamed
					// it's not supposed to happen, but if it's void, for some reason it somehow does
					continue;
				}
			}

			let isInstanceArgument = false;
			if (currentArgument.type === containerType) {
				isInstanceMethod = true;
				isInstanceArgument = true;
			}

			const swiftArgumentName = Generator.snakeCaseToCamelCase(currentArgument.contextualName);
			const swiftArgumentType = this.getPublicTypeSignature(currentArgument.type, containerType);
			if (!isInstanceArgument) {
				swiftMethodArguments.push(`${swiftArgumentName}: ${swiftArgumentType}`);
			}

			const preparedArgument = this.prepareSwiftArgumentForRust(currentArgument, containerType);
			nativeCallPrefix += preparedArgument.conversion;
			nativeCallWrapperPrefix += preparedArgument.methodCallWrapperPrefix;
			nativeCallWrapperSuffix += preparedArgument.methodCallWrapperSuffix;
			nativeCallValueAccessors.push(preparedArgument.accessor);
			nativeCallSuffix += preparedArgument.deferredCleanup;
		}

		// don't mark return types from C as optional because they will be automatically force-unwrapped
		// for some inexplicable reason
		const returnType = method.returnValue.type;
		let swiftReturnType = this.getPublicTypeSignature(returnType, containerType);

		// TODO: THIS IS ABSOLUTELY INSANE AND DANGEROUS! BUG MATT UNTIL IT'S A NULLABLE OPTION!
		const isCommentDeducedNullablePointer = method.documentation.includes('Note that the return value (or a relevant inner pointer) may be NULL or all-0s to represent None');
		if (isCommentDeducedNullablePointer && !swiftReturnType.endsWith('?')) {
			swiftReturnType += '?';
		}

		const returnTypeInfix = (swiftReturnType === 'Void' || swiftMethodName === 'init') ? '' : `-> ${swiftReturnType} `;

		const staticInfix = isInstanceMethod ? '' : 'class ';
		let visibility = 'public';
		if (swiftMethodName === 'free' || swiftMethodName === 'clone') {
			visibility = 'internal';
		}

		let methodDeclarationKeywords = `${visibility} ${staticInfix}func`;
		let returnCommand = 'return returnValue';
		if (swiftMethodName === 'init') {
			// it's a constructor
			methodDeclarationKeywords = visibility;
			returnCommand = 'self.cType = nativeCallResult';
		}

		const preparedReturnValue = this.prepareRustReturnValueForSwift(method.returnValue, containerType);

		if (isCommentDeducedNullablePointer) {
			nativeCallSuffix += `
				// COMMENT-DEDUCED OPTIONAL INFERENCE AND HANDLING:
				// Type group: ${returnType.constructor.name}
				// Type: ${returnType.getName()}
			`;

			if (returnType instanceof RustPrimitiveWrapper) {
				const dataField = returnType.dataField;
				if (dataField.type instanceof RustArray && dataField.type.iteratee instanceof RustPrimitive && Number.isFinite(dataField.type.length)) {
					this.auxiliaryArtifacts.addTuple(dataField.type.iteratee.swiftRawSignature, dataField.type.length!);
					const tupleTypeName = this.getRawTypeName(dataField.type);
					nativeCallSuffix += `
						if nativeCallResult.${dataField.contextualName} == Bindings.arrayTo${tupleTypeName}(array: [${dataField.type.iteratee.swiftRawSignature}](repeating: 0, count: ${dataField.type.length})) {
							return nil
            			}
					`;
				} else {
					throw new Error(`Unhandled comment-deduced optional inference and handling: ${containerType?.getName()}::${swiftMethodName} -> ${returnType.getName()} (${returnType.constructor.name})`);
				}
			} else if (returnType instanceof RustStruct && returnType.fields['inner'] instanceof RustStructField) {
				nativeCallSuffix += `
					if nativeCallResult.inner == nil {
						return nil
					}

					let pointerValue = UInt(bitPattern: nativeCallResult.inner)
					if pointerValue == 0 {
						return nil
					}
				`;
			} else {
				throw new Error(`Unhandled comment-deduced optional inference and handling: ${containerType?.getName()}::${swiftMethodName} -> ${returnType.getName()} (${returnType.constructor.name})`);
			}
		}

		return `
					${this.renderDocComment(method.documentation, 5)}
					${methodDeclarationKeywords} ${swiftMethodName}(${swiftMethodArguments.join(', ')}) ${returnTypeInfix}{
						// native call variable prep
						${nativeCallPrefix}

						// native method call
						let nativeCallResult = ${nativeCallWrapperPrefix}${method.name}(${nativeCallValueAccessors.join(', ')})${nativeCallWrapperSuffix}

						// cleanup
						${nativeCallSuffix}

						// return value (do some wrapping)
						let returnValue = ${preparedReturnValue.wrapperPrefix}nativeCallResult${preparedReturnValue.wrapperSuffix}

						${returnCommand}
					}
		`;
	}

	protected standaloneMethodName(method: RustFunction, containerType: RustType): string {
		let typeNamePrefix = containerType.getName();
		if (typeNamePrefix && typeNamePrefix.startsWith('LDK')) {
			typeNamePrefix = typeNamePrefix.substring('LDK'.length);
		}
		return method.name.replace(typeNamePrefix + '_', '');
	}

	protected standaloneLambdaName(lambda: RustLambda, containerType: RustType): string {
		let typeNamePrefix = containerType.getName();
		if (typeNamePrefix && typeNamePrefix.startsWith('LDK')) {
			typeNamePrefix = typeNamePrefix.substring('LDK'.length);
		}
		return lambda.name.replace(typeNamePrefix + '_', '');
	}

	protected swiftMethodName(method: RustFunction, containerType?: RustType): string {
		let standaloneMethodName = method.name;
		if (containerType) {
			standaloneMethodName = this.standaloneMethodName(method, containerType);
			if (method.returnValue.type === containerType && !['clone', 'none'].includes(standaloneMethodName)) {
				return 'init';
			}
			return Generator.snakeCaseToCamelCase(standaloneMethodName);
		}
		return 'swift' + Generator.snakeCaseToCamelCase(standaloneMethodName, true);
	}

	/**
	 * These are types that technically have Swift wrappers, but that are never exposed to the user
	 * @param type
	 * @protected
	 */
	protected isElidedType(type: RustType): boolean {
		if (type instanceof RustNullableOption || type instanceof RustPrimitiveWrapper || type instanceof RustVector) {
			return true;
		}
		if (type instanceof RustArray) {
			// these are all the tuples
			if (type.iteratee instanceof RustPrimitive) {
				return true;
			}
		}
		if (type instanceof RustTuple) {
			return true;
		}

		return false;
	}

	/**
	 *
	 * @param type
	 * @param containerType
	 * @param context Pretty much never needs to be passed in except for trait Swift callback arguments
	 * @protected
	 */
	protected getPublicTypeSignature(type: RustType, containerType?: RustType, context?: ContextualRustType): string {
		let isTypeElided = this.isElidedType(type);
		const isTypeCurrentContainerType = (type === containerType);
		if (isTypeCurrentContainerType) {
			// even if the type is elided, it isn't within the context of its own internals
			return this.swiftTypeName(type);
		}

		let nullabilitySuffix = '';
		if (context && context.isAsteriskPointer) {
			// we're dealing with a pointer here, which means nullability is possible
			// however, if it's just a vector's field or a string's field, it doesn't mean
			// it should be nullable
			if (!context.isNonnullablePointer) {
				nullabilitySuffix = '?';
			}
		}

		if (!isTypeElided) {
			if (type.parentType && type.parentType === containerType) {
				if (type instanceof RustStruct && containerType instanceof RustTaggedValueEnum) {
					const regex = new RegExp(`^${containerType.name}_LDK(.*)_Body$`);
					const matches = regex.exec(type.name);
					if (Array.isArray(matches)) {
						return matches[1];
					}
				}
			}
			return this.swiftTypeName(type);
		}

		if (type instanceof RustNullableOption) {
			// this becomes a native Swift nullable that we're gonna unwrap or construct,
			// depending on the context
			nullabilitySuffix = '?';

			const someVariantTypeName = this.getPublicTypeSignature(type.someVariant.type);
			// TODO: if outer context already implies a Nullable, find way to avoid `??`
			return someVariantTypeName + '?';
		}

		if (type instanceof RustPrimitiveWrapper) {
			if (type.dataField.type instanceof RustPrimitive) {
				if (type.dataField.isConstant && type.dataField.isAsteriskPointer) {
					if (type.name === 'LDKStr') {
						return 'String' + nullabilitySuffix;
					} else {
						// throw new Error(`Unmapped primitive wrapper with \`const *\` data field: ${type.name}`);
						return `[${type.dataField.type.swiftRawSignature}]${nullabilitySuffix}`;
					}
				} else if (type.dataField.isAsteriskPointer) {
					return `[${type.dataField.type.swiftRawSignature}]${nullabilitySuffix}`;
				}
				return type.dataField.type.swiftRawSignature;
			} else if (type.dataField.type instanceof RustArray) {
				const iteratee = type.dataField.type.iteratee as RustPrimitive;
				return `[${iteratee.swiftRawSignature}]${nullabilitySuffix}`;
			}
		}

		if (type instanceof RustArray) {
			if (type.iteratee instanceof RustPrimitive) {
				return `[${type.iteratee.swiftRawSignature}]${nullabilitySuffix}`;
			}
		}

		if (type instanceof RustVector) {
			const iterateeTypeName = this.getPublicTypeSignature(type.iterateeField.type);
			return `[${iterateeTypeName}]${nullabilitySuffix}`;
		}

		if (type instanceof RustTuple) {
			let subTypes = [];
			for (const currentField of type.orderedFields) {
				subTypes.push(this.getPublicTypeSignature(currentField.type));
			}
			return `(${subTypes.join(', ')})`;
		}

		throw new Error(`Unmapped elided type: ${type.getName()} (${type.constructor.name})`);
	}

	/**
	 * The type name that the Swift compiler natively maps C types into.
	 * For some repeated types like tuples we add aliasing, and register the tuple
	 * as needing conversion in the auxiliary artifact tracker.
	 * @param type
	 * @protected
	 */
	protected getRawTypeName(type: RustType) {
		if (type instanceof RustPrimitive) {
			return type.swiftRawSignature;
		}

		if (type instanceof RustArray) {
			if (type.iteratee instanceof RustPrimitive && Number.isFinite(type.length)) {
				// inlining a really long tuple would be rather ugly, so instead we're gonna
				// declare a type for it and generate some auxiliary conversion and typealiasing
				// artifacts
				this.auxiliaryArtifacts.addTuple(type.iteratee.swiftRawSignature, type.length!);
				return `${type.iteratee.swiftRawSignature}Tuple${type.length}`;
			}

			throw new Error(`Unnamed raw type: ${type.getName()} (${type.constructor.name})`);
		}

		const typeName = type.getName();
		if (!typeName) {
			throw new Error('Unnamed type of kind ' + type.constructor.name);
		}
		return typeName;
	}

	protected prepareSwiftArgumentForRust(argument: RustFunctionArgument, containerType?: RustType): PreparedArgument {
		// this is the name of the variable that the method receives
		const publicName = Generator.snakeCaseToCamelCase(argument.contextualName);
		const preparedArgument: PreparedArgument = {
			// this is the name of the variable that we end up passing to Rust
			// by default, it's unchanged
			name: publicName,

			// this is the string that we pass to the native method
			// usually, it's just the name of the variable, but can contain additional access
			accessor: publicName,

			conversion: '',

			methodCallWrapperPrefix: '',
			methodCallWrapperSuffix: '',

			deferredCleanup: ''
		};

		if (argument.type === containerType) {
			// we're passing self
			preparedArgument.accessor = 'self.cType!';
		} else {

			// these type elision helpers only apply outside the context of the very eliding type

			if (argument.type instanceof RustNullableOption) {
				preparedArgument.name += 'Option';
				// TODO: figure out when label should be `some: `
				preparedArgument.conversion += `
						let ${preparedArgument.name} = ${this.swiftTypeName(argument.type)}(value: ${publicName})
				`;
				preparedArgument.accessor = preparedArgument.name + '.cType!';
			} else if (argument.type instanceof RustPrimitiveWrapper) {
				preparedArgument.name += 'PrimitiveWrapper';
				preparedArgument.conversion += `
						let ${preparedArgument.name} = ${this.swiftTypeName(argument.type)}(value: ${publicName})
				`;
				preparedArgument.accessor = preparedArgument.name + '.cType!';
			} else if (argument.type instanceof RustVector) {
				preparedArgument.name += 'Vector';
				preparedArgument.conversion += `
						let ${preparedArgument.name} = ${this.swiftTypeName(argument.type)}(array: ${publicName})
				`;
				// figure out when it needs to be dangled
				preparedArgument.accessor = preparedArgument.name + '.cType!';
				preparedArgument.deferredCleanup += `
						${preparedArgument.name}.noOpRetain()
				`;
			} else if (argument.type instanceof RustTrait) {
				preparedArgument.accessor = preparedArgument.name + '.activate().cType!';
			} else if (argument.type instanceof RustStruct || argument.type instanceof RustTaggedValueEnum) {
				preparedArgument.accessor = preparedArgument.name + '.cType!';
			} else if (argument.type instanceof RustPrimitiveEnum) {
				preparedArgument.accessor = preparedArgument.name + '.getCValue()';
			} else if (argument.type instanceof RustArray) {
				const iteratee = argument.type.iteratee;
				if (iteratee instanceof RustPrimitive && Number.isFinite(argument.type.length)) {
					// inlining a really long tuple would be rather ugly, so instead we're gonna
					// declare a type for it and generate some auxiliary conversion and typealiasing
					// artifacts
					const tupleTypeName = this.getRawTypeName(argument.type);
					preparedArgument.name = `tupled${Generator.snakeCaseToCamelCase(preparedArgument.name, true)}`;
					this.auxiliaryArtifacts.addTuple(iteratee.swiftRawSignature, argument.type.length!);
					preparedArgument.conversion += `
						let ${preparedArgument.name} = Bindings.arrayTo${tupleTypeName}(array: ${preparedArgument.accessor})
					`;
					preparedArgument.accessor = preparedArgument.name;
				}
			} else if (argument.type instanceof RustPrimitive) {
				// nothing to do here
			} else {
				throw new Error(`Unsupported native argument type: ${argument.type.getName()} (${argument.type.constructor.name})`);
			}
		}

		if (argument.isAsteriskPointer) {
			// we must wrap the native call in a withUnsafePointer component
			const typeName = this.getRawTypeName(argument.type);
			const mutabilityInfix = argument.isConstant ? '' : 'Mutable';

			// TODO: figure out when exactly this is necessary. Seems to be 1:1 with mutable, but not sure yet
			const inoutAmpersandInfix = argument.isConstant ? '' : '&';

			preparedArgument.name += 'Pointer';
			preparedArgument.methodCallWrapperPrefix += `
						withUnsafe${mutabilityInfix}Pointer(to: ${inoutAmpersandInfix}${preparedArgument.accessor}) { (${preparedArgument.name}: Unsafe${mutabilityInfix}Pointer<${typeName}>) in
			`;
			preparedArgument.methodCallWrapperSuffix += `
						}
			`;

			// the wrapper accesses the variable normally, and introduces a new variable name by which to refer to the value
			preparedArgument.accessor = preparedArgument.name;
		}

		return preparedArgument;
	}

	protected prepareRustReturnValueForSwift(returnType: RustFunctionReturnValue, containerType?: RustType): PreparedReturnValue {
		const preparedReturnValue: PreparedReturnValue = {
			wrapperPrefix: '',
			wrapperSuffix: ''
		};

		// TODO: add support for anchor infix and dangle()/danglingClone() suffixes
		if (returnType.type instanceof RustVector || returnType.type instanceof RustTuple) {
			preparedReturnValue.wrapperPrefix += `${this.swiftTypeName(returnType.type)}(cType: `;
			preparedReturnValue.wrapperSuffix += `).getValue()`;
		} else if (returnType.type instanceof RustTrait) {
			preparedReturnValue.wrapperPrefix += `NativelyImplemented${this.swiftTypeName(returnType.type)}(cType: `;
			preparedReturnValue.wrapperSuffix += `, anchor: self)`;
		} else if (returnType.type instanceof RustNullableOption) {
			// nullable option must come BEFORE tagged value enum, because it's a subclass
			preparedReturnValue.wrapperPrefix += `${this.swiftTypeName(returnType.type)}(cType: `;
			preparedReturnValue.wrapperSuffix += `)`;
			if (returnType.type !== containerType) {
				// it's an elided type, so we pass it through
				preparedReturnValue.wrapperSuffix += '.getValue()';
			}
		} else if (returnType.type instanceof RustStruct || returnType.type instanceof RustResult || returnType.type instanceof RustTaggedValueEnum) {
			preparedReturnValue.wrapperPrefix += `${this.swiftTypeName(returnType.type)}(cType: `;
			preparedReturnValue.wrapperSuffix += `)`;
		} else if (returnType.type instanceof RustPrimitive) {
			// nothing to do here
			return preparedReturnValue;
		} else if (returnType.type instanceof RustPrimitiveEnum) {
			preparedReturnValue.wrapperPrefix += `${this.swiftTypeName(returnType.type)}(value: `;
			preparedReturnValue.wrapperSuffix += `)`;
		} else {
			throw new Error(`Unsupported return type ${returnType.type.getName()} of kind ${returnType.type.constructor.name}`);
		}
		return preparedReturnValue;
	}

	protected inheritedInits(type: RustType): string {
		const typeName = type.getName();
		if (!typeName) {
			throw new Error('Unnamed type of kind ' + type.constructor.name);
		}

		return `
					private static var instanceCounter: UInt = 0
					internal let instanceNumber: UInt

					internal var cType: ${typeName}?

					public init(cType: ${typeName}) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = cType
						super.init(conflictAvoidingVariableName: 0)
					}

					public init(cType: ${typeName}, anchor: NativeTypeWrapper) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = cType
						super.init(conflictAvoidingVariableName: 0)
						self.dangling = true
						try! self.addAnchor(anchor: anchor)
					}
		`;
	}

	protected renderDanglingCloneAndDeinitMethods(type: RustType): string {
		let danglingCloneCode = '';
		let freeCode = '';

		const swiftTypeName = this.swiftTypeName(type);

		if (this.hasCloneMethod(type)) {
			danglingCloneCode = `
				internal func danglingClone() -> ${swiftTypeName} {
					let dangledClone = self.clone()
					dangledClone.dangling = true
					return dangledClone
				}
			`;
		}

		if (this.hasFreeMethod(type)) {
			freeCode = `
				deinit {
					if !self.dangling {
						Bindings.print("Freeing ${swiftTypeName} \\(self.instanceNumber).")
						self.free()
					} else {
						Bindings.print("Not freeing ${swiftTypeName} \\(self.instanceNumber) due to dangle.")
					}
				}
			`;
		}

		return Generator.reindentCode(danglingCloneCode + freeCode, 5);

	}

	protected renderDocComment(comment: string, indentationDepth: number = 0): string {
		const indentation = '\t'.repeat(indentationDepth);
		const commentPrefix = '/// ';
		return commentPrefix + comment.replaceAll('\n', '\n' + indentation + commentPrefix);
	}

	private hasMethod(type: RustType, methodName: string) {
		let methods: RustFunction[] = [];
		if (type instanceof RustStruct) {
			methods = type.methods;
		} else if (type instanceof RustTaggedValueEnum) {
			methods = type.methods;
		}
		for (const currentMethod of methods) {
			const standaloneName = this.standaloneMethodName(currentMethod, type);
			if (standaloneName === methodName) {
				return true;
			}
		}

		if (type instanceof RustTrait) {
			for (const currentLambda of type.lambdas) {
				const standaloneName = this.standaloneLambdaName(currentLambda, type);
				if (standaloneName === methodName) {
					return true;
				}
			}
		}
		return false;
	}

	private outputFilePath(type: RustType): string {
		let basePath = this.config.getOutputBaseDirectoryPath();
		const fileName = this.swiftTypeName(type) + '.swift';
		const outputPath = path.join(basePath, this.outputDirectorySuffix(), fileName);
		return outputPath;
	}

}

export interface PreparedArgument {
	/**
	 * This is the name of the variable that we end up passing to Rust
	 * In the simplest scenario, it's the public argument name
	 */
	name: string,

	/**
	 * This is the exact string that is passed at the native function's call site
	 * By default it's just the name of the variable, but can have complications like `.cType!`
	 */
	accessor: string,

	/**
	 * This is code that prepares the variable received from Swift to be passed to Rust
	 */
	conversion: string,

	methodCallWrapperPrefix: string;
	methodCallWrapperSuffix: string;

	/**
	 * This is code that is executed after the return value is constructed. Usually for either
	 * memory deallocation or, ironically, retention beyond the call site
	 */
	deferredCleanup: string
}

export interface PreparedReturnValue {
	wrapperPrefix: string;
	wrapperSuffix: string;
}