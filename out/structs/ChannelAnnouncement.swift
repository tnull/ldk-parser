
				
			#if SWIFT_PACKAGE
			import LDKHeaders
			#endif

			public typealias ChannelAnnouncement = Bindings.ChannelAnnouncement

			extension Bindings {
		

				/// A channel_announcement message to be sent or received from a peer
				public class ChannelAnnouncement: NativeTypeWrapper {

					
					private static var instanceCounter: UInt = 0
					internal let instanceNumber: UInt

					internal var cType: LDKChannelAnnouncement?

					public init(pointer: LDKChannelAnnouncement) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = pointer
						super.init(conflictAvoidingVariableName: 0)
					}

					public init(pointer: LDKChannelAnnouncement, anchor: NativeTypeWrapper) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = pointer
						super.init(conflictAvoidingVariableName: 0)
						self.dangling = true
						try! self.addAnchor(anchor: anchor)
					}
		

					
					/// Frees any resources used by the ChannelAnnouncement, if is_owned is set and inner is non-NULL.
					internal func free() {
						// native call variable prep
						

						// native method call
						let nativeCallResult = ChannelAnnouncement_free(self.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Authentication of the announcement by the first public node
					public func getNodeSignature_1() -> [UInt8] {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisPtrPointer: UnsafePointer<LDKChannelAnnouncement>) in
			ChannelAnnouncement_get_node_signature_1(thisPtrPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = Signature(pointer: nativeCallResult)

						return returnValue
					}
		
					/// Authentication of the announcement by the first public node
					public func setNodeSignature_1(val: [UInt8]) {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisPtrPointer: UnsafePointer<LDKChannelAnnouncement>) in
			ChannelAnnouncement_set_node_signature_1(thisPtrPointer, val.cType!)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Authentication of the announcement by the second public node
					public func getNodeSignature_2() -> [UInt8] {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisPtrPointer: UnsafePointer<LDKChannelAnnouncement>) in
			ChannelAnnouncement_get_node_signature_2(thisPtrPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = Signature(pointer: nativeCallResult)

						return returnValue
					}
		
					/// Authentication of the announcement by the second public node
					public func setNodeSignature_2(val: [UInt8]) {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisPtrPointer: UnsafePointer<LDKChannelAnnouncement>) in
			ChannelAnnouncement_set_node_signature_2(thisPtrPointer, val.cType!)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Proof of funding UTXO ownership by the first public node
					public func getBitcoinSignature_1() -> [UInt8] {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisPtrPointer: UnsafePointer<LDKChannelAnnouncement>) in
			ChannelAnnouncement_get_bitcoin_signature_1(thisPtrPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = Signature(pointer: nativeCallResult)

						return returnValue
					}
		
					/// Proof of funding UTXO ownership by the first public node
					public func setBitcoinSignature_1(val: [UInt8]) {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisPtrPointer: UnsafePointer<LDKChannelAnnouncement>) in
			ChannelAnnouncement_set_bitcoin_signature_1(thisPtrPointer, val.cType!)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Proof of funding UTXO ownership by the second public node
					public func getBitcoinSignature_2() -> [UInt8] {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisPtrPointer: UnsafePointer<LDKChannelAnnouncement>) in
			ChannelAnnouncement_get_bitcoin_signature_2(thisPtrPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = Signature(pointer: nativeCallResult)

						return returnValue
					}
		
					/// Proof of funding UTXO ownership by the second public node
					public func setBitcoinSignature_2(val: [UInt8]) {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisPtrPointer: UnsafePointer<LDKChannelAnnouncement>) in
			ChannelAnnouncement_set_bitcoin_signature_2(thisPtrPointer, val.cType!)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// The actual announcement
					public func getContents() -> UnsignedChannelAnnouncement {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisPtrPointer: UnsafePointer<LDKChannelAnnouncement>) in
			ChannelAnnouncement_get_contents(thisPtrPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = UnsignedChannelAnnouncement(pointer: nativeCallResult)

						return returnValue
					}
		
					/// The actual announcement
					public func setContents(val: UnsignedChannelAnnouncement) {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisPtrPointer: UnsafePointer<LDKChannelAnnouncement>) in
			ChannelAnnouncement_set_contents(thisPtrPointer, val.cType!)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Constructs a new ChannelAnnouncement given each field
					public init(nodeSignature_1Arg: [UInt8], nodeSignature_2Arg: [UInt8], bitcoinSignature_1Arg: [UInt8], bitcoinSignature_2Arg: [UInt8], contentsArg: UnsignedChannelAnnouncement) {
						// native call variable prep
						

						// native method call
						let nativeCallResult = ChannelAnnouncement_new(nodeSignature_1Arg.cType!, nodeSignature_2Arg.cType!, bitcoinSignature_1Arg.cType!, bitcoinSignature_2Arg.cType!, contentsArg.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = ChannelAnnouncement(pointer: nativeCallResult)

						self.cType = nativeCallResult
					}
		
					/// Creates a copy of the ChannelAnnouncement
					internal func clone() -> ChannelAnnouncement {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (origPointer: UnsafePointer<LDKChannelAnnouncement>) in
			ChannelAnnouncement_clone(origPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = ChannelAnnouncement(pointer: nativeCallResult)

						return returnValue
					}
		
					/// Checks if two ChannelAnnouncements contain equal inner contents.
					/// This ignores pointers and is_owned flags and looks at the values in fields.
					/// Two objects with NULL inner values will be considered "equal" here.
					public func eq() -> Bool {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (aPointer: UnsafePointer<LDKChannelAnnouncement>) in
			
						withUnsafePointer(to: self.cType!) { (bPointer: UnsafePointer<LDKChannelAnnouncement>) in
			ChannelAnnouncement_eq(aPointer, bPointer)
						}
			
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Serialize the ChannelAnnouncement object into a byte array which can be read by ChannelAnnouncement_read
					public func write() -> [UInt8] {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (objPointer: UnsafePointer<LDKChannelAnnouncement>) in
			ChannelAnnouncement_write(objPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = Vec_u8Z(pointer: nativeCallResult).getValue()

						return returnValue
					}
		
					/// Read a ChannelAnnouncement from a byte array, created by ChannelAnnouncement_write
					public class func read(ser: [UInt8]) -> Result_ChannelAnnouncementDecodeErrorZ {
						// native call variable prep
						

						// native method call
						let nativeCallResult = ChannelAnnouncement_read(ser.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = Result_ChannelAnnouncementDecodeErrorZ(pointer: nativeCallResult)

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
		

					internal func dangle() -> ChannelAnnouncement {
						self.dangling = true
						return self
					}

					
					internal func danglingClone() -> ChannelAnnouncement {
						let dangledClone = self.clone()
						dangledClone.dangling = true
						return dangledClone
					}
			
					deinit {
						if !self.dangling {
							Bindings.print("Freeing ChannelAnnouncement \(self.instanceNumber).")
							self.free()
						} else {
							Bindings.print("Not freeing ChannelAnnouncement \(self.instanceNumber) due to dangle.")
						}
					}
			

				}

				
			}
		
		