
			#if SWIFT_PACKAGE
			import LDKHeaders
			#endif

			/// A CResult_RouteHopDecodeErrorZ represents the result of a fallible operation,
			/// containing a crate::lightning::routing::router::RouteHop on success and a crate::lightning::ln::msgs::DecodeError on failure.
			/// `result_ok` indicates the overall state, and the contents are provided via `contents`.
			public typealias Result_RouteHopDecodeErrorZ = Bindings.Result_RouteHopDecodeErrorZ

			extension Bindings {

				/// A CResult_RouteHopDecodeErrorZ represents the result of a fallible operation,
				/// containing a crate::lightning::routing::router::RouteHop on success and a crate::lightning::ln::msgs::DecodeError on failure.
				/// `result_ok` indicates the overall state, and the contents are provided via `contents`.
				public class Result_RouteHopDecodeErrorZ: NativeTypeWrapper {

					
					private static var instanceCounter: UInt = 0
					internal let instanceNumber: UInt

					internal var cType: LDKCResult_RouteHopDecodeErrorZ?

					public init(cType: LDKCResult_RouteHopDecodeErrorZ) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = cType
						super.init(conflictAvoidingVariableName: 0)
					}

					public init(cType: LDKCResult_RouteHopDecodeErrorZ, anchor: NativeTypeWrapper) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = cType
						super.init(conflictAvoidingVariableName: 0)
						self.dangling = true
						try! self.addAnchor(anchor: anchor)
					}
		

					
					/// Creates a new CResult_RouteHopDecodeErrorZ in the success state.
					public class func initWithOk(o: RouteHop) -> Result_RouteHopDecodeErrorZ {
						// native call variable prep
						

						// native method call
						let nativeCallResult = CResult_RouteHopDecodeErrorZ_ok(o.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = Result_RouteHopDecodeErrorZ(cType: nativeCallResult)

						return returnValue
					}
		
					/// Creates a new CResult_RouteHopDecodeErrorZ in the error state.
					public class func initWithErr(e: DecodeError) -> Result_RouteHopDecodeErrorZ {
						// native call variable prep
						

						// native method call
						let nativeCallResult = CResult_RouteHopDecodeErrorZ_err(e.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = Result_RouteHopDecodeErrorZ(cType: nativeCallResult)

						return returnValue
					}
		
					/// Frees any resources used by the CResult_RouteHopDecodeErrorZ.
					internal func free() {
						// native call variable prep
						

						// native method call
						let nativeCallResult = CResult_RouteHopDecodeErrorZ_free(self.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Creates a new CResult_RouteHopDecodeErrorZ which has the same data as `orig`
					/// but with all dynamically-allocated buffers duplicated in new buffers.
					internal func clone() -> Result_RouteHopDecodeErrorZ {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (origPointer: UnsafePointer<LDKCResult_RouteHopDecodeErrorZ>) in
				CResult_RouteHopDecodeErrorZ_clone(origPointer)
						}
				

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = Result_RouteHopDecodeErrorZ(cType: nativeCallResult)

						return returnValue
					}
		

					public func isOk() -> Bool {
						return self.cType?.result_ok == true
					}

					
					public func getError() -> DecodeError? {
						if self.cType?.result_ok == false {
							return DecodeError(cType: self.cType!.contents.err.pointee, anchor: self).dangle()
						}
						return nil
					}
					

					
					public func getValue() -> RouteHop? {
						if self.cType?.result_ok == true {
							return RouteHop(cType: self.cType!.contents.result.pointee, anchor: self).dangle()
						}
						return nil
					}
					

					internal func dangle() -> Result_RouteHopDecodeErrorZ {
        				self.dangling = true
						return self
					}

										

				}

			}
		