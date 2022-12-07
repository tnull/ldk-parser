
				
			#if SWIFT_PACKAGE
			import LDKHeaders
			#endif

			public typealias NodeAlias = Bindings.NodeAlias

			extension Bindings {
		

				/// A user-defined name for a node, which may be used when displaying the node in a graph.
				/// 
				/// Since node aliases are provided by third parties, they are a potential avenue for injection
				/// attacks. Care must be taken when processing.
				public class NodeAlias: NativeTypeWrapper {

					
					private static var instanceCounter: UInt = 0
					internal let instanceNumber: UInt

					internal var cType: LDKNodeAlias?

					public init(pointer: LDKNodeAlias) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = pointer
						super.init(conflictAvoidingVariableName: 0)
					}

					public init(pointer: LDKNodeAlias, anchor: NativeTypeWrapper) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = pointer
						super.init(conflictAvoidingVariableName: 0)
						self.dangling = true
						try! self.addAnchor(anchor: anchor)
					}
		

					
					/// Frees any resources used by the NodeAlias, if is_owned is set and inner is non-NULL.
					internal func free() {
						// native call variable prep
						

						// native method call
						let nativeCallResult = NodeAlias_free(self.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// 
					public func setA(val: [UInt8]) {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisPtrPointer: UnsafePointer<LDKNodeAlias>) in
			NodeAlias_set_a(thisPtrPointer, val.cType!)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Constructs a new NodeAlias given each field
					public init(aArg: [UInt8]) {
						// native call variable prep
						

						// native method call
						let nativeCallResult = NodeAlias_new(aArg.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = NodeAlias(pointer: nativeCallResult)

						self.cType = nativeCallResult
					}
		
					/// Creates a copy of the NodeAlias
					internal func clone() -> NodeAlias {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (origPointer: UnsafePointer<LDKNodeAlias>) in
			NodeAlias_clone(origPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = NodeAlias(pointer: nativeCallResult)

						return returnValue
					}
		
					/// Checks if two NodeAliass contain equal inner contents.
					/// This ignores pointers and is_owned flags and looks at the values in fields.
					/// Two objects with NULL inner values will be considered "equal" here.
					public func eq() -> Bool {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (aPointer: UnsafePointer<LDKNodeAlias>) in
			
						withUnsafePointer(to: self.cType!) { (bPointer: UnsafePointer<LDKNodeAlias>) in
			NodeAlias_eq(aPointer, bPointer)
						}
			
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Serialize the NodeAlias object into a byte array which can be read by NodeAlias_read
					public func write() -> [UInt8] {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (objPointer: UnsafePointer<LDKNodeAlias>) in
			NodeAlias_write(objPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = Vec_u8Z(pointer: nativeCallResult).getValue()

						return returnValue
					}
		
					/// Read a NodeAlias from a byte array, created by NodeAlias_write
					public class func read(ser: [UInt8]) -> Result_NodeAliasDecodeErrorZ {
						// native call variable prep
						

						// native method call
						let nativeCallResult = NodeAlias_read(ser.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = Result_NodeAliasDecodeErrorZ(pointer: nativeCallResult)

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
		

					internal func dangle() -> NodeAlias {
						self.dangling = true
						return self
					}

					
					internal func danglingClone() -> NodeAlias {
						let dangledClone = self.clone()
						dangledClone.dangling = true
						return dangledClone
					}
			
					deinit {
						if !self.dangling {
							Bindings.print("Freeing NodeAlias \(self.instanceNumber).")
							self.free()
						} else {
							Bindings.print("Not freeing NodeAlias \(self.instanceNumber) due to dangle.")
						}
					}
			

				}

				
			}
		
		