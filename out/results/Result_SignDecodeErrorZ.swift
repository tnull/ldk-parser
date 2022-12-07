
			#if SWIFT_PACKAGE
			import LDKHeaders
			#endif

			public typealias Result_SignDecodeErrorZ = Bindings.Result_SignDecodeErrorZ

			extension Bindings {

				/// A CResult_SignDecodeErrorZ represents the result of a fallible operation,
				/// containing a crate::lightning::chain::keysinterface::Sign on success and a crate::lightning::ln::msgs::DecodeError on failure.
				/// `result_ok` indicates the overall state, and the contents are provided via `contents`.
				public class Result_SignDecodeErrorZ: NativeTypeWrapper {

					
					private static var instanceCounter: UInt = 0
					internal let instanceNumber: UInt

					internal var cType: LDKCResult_SignDecodeErrorZ?

					public init(pointer: LDKCResult_SignDecodeErrorZ) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = pointer
						super.init(conflictAvoidingVariableName: 0)
					}

					public init(pointer: LDKCResult_SignDecodeErrorZ, anchor: NativeTypeWrapper) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = pointer
						super.init(conflictAvoidingVariableName: 0)
						self.dangling = true
						try! self.addAnchor(anchor: anchor)
					}
		

					
					/// Creates a new CResult_SignDecodeErrorZ in the success state.
					public init(o: Sign) {
						// native call variable prep
						

						// native method call
						let nativeCallResult = CResult_SignDecodeErrorZ_ok(o.activate().cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = Result_SignDecodeErrorZ(pointer: nativeCallResult)

						self.cType = nativeCallResult
					}
		
					/// Creates a new CResult_SignDecodeErrorZ in the error state.
					public init(e: DecodeError) {
						// native call variable prep
						

						// native method call
						let nativeCallResult = CResult_SignDecodeErrorZ_err(e.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = Result_SignDecodeErrorZ(pointer: nativeCallResult)

						self.cType = nativeCallResult
					}
		
					/// Frees any resources used by the CResult_SignDecodeErrorZ.
					internal func free() {
						// native call variable prep
						

						// native method call
						let nativeCallResult = CResult_SignDecodeErrorZ_free(self.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Creates a new CResult_SignDecodeErrorZ which has the same data as `orig`
					/// but with all dynamically-allocated buffers duplicated in new buffers.
					internal func clone() -> Result_SignDecodeErrorZ {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (origPointer: UnsafePointer<LDKCResult_SignDecodeErrorZ>) in
			CResult_SignDecodeErrorZ_clone(origPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = Result_SignDecodeErrorZ(pointer: nativeCallResult)

						return returnValue
					}
		

					public func isOk() -> Bool {
						return self.cType?.result_ok == true
					}

					public func getError() -> DecodeError? {
						if self.cType?.result_ok == false {
							return DecodeError(pointer: self.cType!.contents.err.pointee)
						}
						return nil
					}

					public func getValue() -> Sign? {
						if self.cType?.result_ok == true {
							return NativelyImplementedSign(pointer: self.cType!.contents.result.pointee, anchor: self)
						}
						return nil
					}

					internal func dangle() -> Result_SignDecodeErrorZ {
        				self.dangling = true
						return self
					}

										

				}

			}
		