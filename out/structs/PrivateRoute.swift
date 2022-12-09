
				
			#if SWIFT_PACKAGE
			import LDKHeaders
			#endif

			/// Private routing information
			/// 
			/// # Invariants
			/// The encoded route has to be <1024 5bit characters long (<=639 bytes or <=12 hops)
			public typealias PrivateRoute = Bindings.PrivateRoute

			extension Bindings {
		

				/// Private routing information
				/// 
				/// # Invariants
				/// The encoded route has to be <1024 5bit characters long (<=639 bytes or <=12 hops)
				public class PrivateRoute: NativeTypeWrapper {

					
					private static var instanceCounter: UInt = 0
					internal let instanceNumber: UInt

					internal var cType: LDKPrivateRoute?

					public init(cType: LDKPrivateRoute) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = cType
						super.init(conflictAvoidingVariableName: 0)
					}

					public init(cType: LDKPrivateRoute, anchor: NativeTypeWrapper) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = cType
						super.init(conflictAvoidingVariableName: 0)
						self.dangling = true
						try! self.addAnchor(anchor: anchor)
					}
		

					
					/// Frees any resources used by the PrivateRoute, if is_owned is set and inner is non-NULL.
					internal func free() {
						// native call variable prep
						

						// native method call
						let nativeCallResult = PrivateRoute_free(self.cType!)

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = nativeCallResult
						

						return returnValue
					}
		
					/// Creates a copy of the PrivateRoute
					internal func clone() -> PrivateRoute {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (origPointer: UnsafePointer<LDKPrivateRoute>) in
				PrivateRoute_clone(origPointer)
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = PrivateRoute(cType: nativeCallResult)
						

						return returnValue
					}
		
					/// Checks if two PrivateRoutes contain equal inner contents.
					public func hash() -> UInt64 {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (oPointer: UnsafePointer<LDKPrivateRoute>) in
				PrivateRoute_hash(oPointer)
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = nativeCallResult
						

						return returnValue
					}
		
					/// Checks if two PrivateRoutes contain equal inner contents.
					/// This ignores pointers and is_owned flags and looks at the values in fields.
					/// Two objects with NULL inner values will be considered "equal" here.
					public func eq() -> Bool {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (aPointer: UnsafePointer<LDKPrivateRoute>) in
				
						withUnsafePointer(to: self.cType!) { (bPointer: UnsafePointer<LDKPrivateRoute>) in
				PrivateRoute_eq(aPointer, bPointer)
						}
				
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = nativeCallResult
						

						return returnValue
					}
		
					/// Creates a new (partial) route from a list of hops
					public class func new(hops: RouteHint) -> Result_PrivateRouteCreationErrorZ {
						// native call variable prep
						

						// native method call
						let nativeCallResult = PrivateRoute_new(hops.cType!)

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = Result_PrivateRouteCreationErrorZ(cType: nativeCallResult)
						

						return returnValue
					}
		
					/// Returns the underlying list of hops
					public func intoInner() -> RouteHint {
						// native call variable prep
						

						// native method call
						let nativeCallResult = PrivateRoute_into_inner(self.cType!)

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = RouteHint(cType: nativeCallResult)
						

						return returnValue
					}
		

					
					/// Indicates that this is the only struct which contains the same pointer.
					/// Rust functions which take ownership of an object provided via an argument require
					/// this to be true and invalidate the object pointed to by inner.
					public func isOwned() -> Bool {
						// return value (do some wrapping)
						let returnValue = self.cType!.is_owned

						return returnValue;
					}
		

					internal func dangle() -> PrivateRoute {
						self.dangling = true
						return self
					}

					
					internal func danglingClone() -> PrivateRoute {
						let dangledClone = self.clone()
						dangledClone.dangling = true
						return dangledClone
					}
			
					deinit {
						if !self.dangling {
							Bindings.print("Freeing PrivateRoute \(self.instanceNumber).")
							self.free()
						} else {
							Bindings.print("Not freeing PrivateRoute \(self.instanceNumber) due to dangle.")
						}
					}
			

				}

				
			}
		
		