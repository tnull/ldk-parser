
			#if SWIFT_PACKAGE
			import LDKHeaders
			#endif

			public typealias Result_C2Tuple_SignatureCVec_SignatureZZNoneZ = Bindings.Result_C2Tuple_SignatureCVec_SignatureZZNoneZ

			extension Bindings {

				/// A CResult_C2Tuple_SignatureCVec_SignatureZZNoneZ represents the result of a fallible operation,
				/// containing a crate::c_types::derived::C2Tuple_SignatureCVec_SignatureZZ on success and a () on failure.
				/// `result_ok` indicates the overall state, and the contents are provided via `contents`.
				public class Result_C2Tuple_SignatureCVec_SignatureZZNoneZ: NativeTypeWrapper {

					
					private static var instanceCounter: UInt = 0
					internal let instanceNumber: UInt

					internal var cType: LDKCResult_C2Tuple_SignatureCVec_SignatureZZNoneZ?

					public init(pointer: LDKCResult_C2Tuple_SignatureCVec_SignatureZZNoneZ) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = pointer
						super.init(conflictAvoidingVariableName: 0)
					}

					public init(pointer: LDKCResult_C2Tuple_SignatureCVec_SignatureZZNoneZ, anchor: NativeTypeWrapper) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = pointer
						super.init(conflictAvoidingVariableName: 0)
						self.dangling = true
						try! self.addAnchor(anchor: anchor)
					}
		

					
					/// Creates a new CResult_C2Tuple_SignatureCVec_SignatureZZNoneZ in the success state.
					public init(o: ([UInt8], [[UInt8]])) {
						// native call variable prep
						

						// native method call
						let nativeCallResult = CResult_C2Tuple_SignatureCVec_SignatureZZNoneZ_ok(o.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = Result_C2Tuple_SignatureCVec_SignatureZZNoneZ(pointer: nativeCallResult)

						self.cType = nativeCallResult
					}
		
					/// Creates a new CResult_C2Tuple_SignatureCVec_SignatureZZNoneZ in the error state.
					public init() {
						// native call variable prep
						

						// native method call
						let nativeCallResult = CResult_C2Tuple_SignatureCVec_SignatureZZNoneZ_err()

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = Result_C2Tuple_SignatureCVec_SignatureZZNoneZ(pointer: nativeCallResult)

						self.cType = nativeCallResult
					}
		
					/// Frees any resources used by the CResult_C2Tuple_SignatureCVec_SignatureZZNoneZ.
					internal func free() {
						// native call variable prep
						

						// native method call
						let nativeCallResult = CResult_C2Tuple_SignatureCVec_SignatureZZNoneZ_free(self.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Creates a new CResult_C2Tuple_SignatureCVec_SignatureZZNoneZ which has the same data as `orig`
					/// but with all dynamically-allocated buffers duplicated in new buffers.
					internal func clone() -> Result_C2Tuple_SignatureCVec_SignatureZZNoneZ {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (origPointer: UnsafePointer<LDKCResult_C2Tuple_SignatureCVec_SignatureZZNoneZ>) in
			CResult_C2Tuple_SignatureCVec_SignatureZZNoneZ_clone(origPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = Result_C2Tuple_SignatureCVec_SignatureZZNoneZ(pointer: nativeCallResult)

						return returnValue
					}
		

					public func isOk() -> Bool {
						return self.cType?.result_ok == true
					}

					public func getError() -> Void? {
						if self.cType?.result_ok == false {
							return self.cType!.contents.err.pointee
						}
						return nil
					}

					public func getValue() -> ([UInt8], [[UInt8]])? {
						if self.cType?.result_ok == true {
							return Tuple_SignatureCVec_SignatureZZ(pointer: self.cType!.contents.result.pointee).getValue()
						}
						return nil
					}

					internal func dangle() -> Result_C2Tuple_SignatureCVec_SignatureZZNoneZ {
        				self.dangling = true
						return self
					}

										

				}

			}
		