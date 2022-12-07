
			#if SWIFT_PACKAGE
			import LDKHeaders
			#endif

			public typealias Result_NetworkGraphDecodeErrorZ = Bindings.Result_NetworkGraphDecodeErrorZ

			extension Bindings {

				/// A CResult_NetworkGraphDecodeErrorZ represents the result of a fallible operation,
				/// containing a crate::lightning::routing::gossip::NetworkGraph on success and a crate::lightning::ln::msgs::DecodeError on failure.
				/// `result_ok` indicates the overall state, and the contents are provided via `contents`.
				public class Result_NetworkGraphDecodeErrorZ: NativeTypeWrapper {

					
					private static var instanceCounter: UInt = 0
					internal let instanceNumber: UInt

					internal var cType: LDKCResult_NetworkGraphDecodeErrorZ?

					public init(pointer: LDKCResult_NetworkGraphDecodeErrorZ) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = pointer
						super.init(conflictAvoidingVariableName: 0)
					}

					public init(pointer: LDKCResult_NetworkGraphDecodeErrorZ, anchor: NativeTypeWrapper) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = pointer
						super.init(conflictAvoidingVariableName: 0)
						self.dangling = true
						try! self.addAnchor(anchor: anchor)
					}
		

					
					/// Creates a new CResult_NetworkGraphDecodeErrorZ in the success state.
					public init(o: NetworkGraph) {
						// native call variable prep
						

						// native method call
						let nativeCallResult = CResult_NetworkGraphDecodeErrorZ_ok(o.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = Result_NetworkGraphDecodeErrorZ(pointer: nativeCallResult)

						self.cType = nativeCallResult
					}
		
					/// Creates a new CResult_NetworkGraphDecodeErrorZ in the error state.
					public init(e: DecodeError) {
						// native call variable prep
						

						// native method call
						let nativeCallResult = CResult_NetworkGraphDecodeErrorZ_err(e.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = Result_NetworkGraphDecodeErrorZ(pointer: nativeCallResult)

						self.cType = nativeCallResult
					}
		
					/// Frees any resources used by the CResult_NetworkGraphDecodeErrorZ.
					internal func free() {
						// native call variable prep
						

						// native method call
						let nativeCallResult = CResult_NetworkGraphDecodeErrorZ_free(self.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

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

					public func getValue() -> NetworkGraph? {
						if self.cType?.result_ok == true {
							return NetworkGraph(pointer: self.cType!.contents.result.pointee)
						}
						return nil
					}

					internal func dangle() -> Result_NetworkGraphDecodeErrorZ {
        				self.dangling = true
						return self
					}

										

				}

			}
		