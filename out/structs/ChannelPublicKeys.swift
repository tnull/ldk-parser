
				
			#if SWIFT_PACKAGE
			import LDKHeaders
			#endif

			/// One counterparty's public keys which do not change over the life of a channel.
			public typealias ChannelPublicKeys = Bindings.ChannelPublicKeys

			extension Bindings {
		

				/// One counterparty's public keys which do not change over the life of a channel.
				public class ChannelPublicKeys: NativeTypeWrapper {

					
					private static var instanceCounter: UInt = 0
					internal let instanceNumber: UInt

					internal var cType: LDKChannelPublicKeys?

					public init(cType: LDKChannelPublicKeys) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = cType
						
						super.init(conflictAvoidingVariableName: 0)
					}

					public init(cType: LDKChannelPublicKeys, anchor: NativeTypeWrapper) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = cType
						
						super.init(conflictAvoidingVariableName: 0)
						self.dangling = true
						try! self.addAnchor(anchor: anchor)
					}
		

					
					/// Frees any resources used by the ChannelPublicKeys, if is_owned is set and inner is non-NULL.
					internal func free() {
						// native call variable prep
						

						// native method call
						let nativeCallResult = ChannelPublicKeys_free(self.cType!)

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = nativeCallResult
						

						return returnValue
					}
		
					/// The public key which is used to sign all commitment transactions, as it appears in the
					/// on-chain channel lock-in 2-of-2 multisig output.
					public func getFundingPubkey() -> [UInt8] {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisPtrPointer: UnsafePointer<LDKChannelPublicKeys>) in
				ChannelPublicKeys_get_funding_pubkey(thisPtrPointer)
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = PublicKey(cType: nativeCallResult, anchor: self).getValue()
						

						return returnValue
					}
		
					/// The public key which is used to sign all commitment transactions, as it appears in the
					/// on-chain channel lock-in 2-of-2 multisig output.
					public func setFundingPubkey(val: [UInt8]) {
						// native call variable prep
						
						let valPrimitiveWrapper = PublicKey(value: val)
				

						// native method call
						let nativeCallResult = 
						withUnsafeMutablePointer(to: &self.cType!) { (thisPtrPointer: UnsafeMutablePointer<LDKChannelPublicKeys>) in
				ChannelPublicKeys_set_funding_pubkey(thisPtrPointer, valPrimitiveWrapper.cType!)
						}
				

						// cleanup
						
						// for elided types, we need this
						valPrimitiveWrapper.noOpRetain()
				

						
						// return value (do some wrapping)
						let returnValue = nativeCallResult
						

						return returnValue
					}
		
					/// The base point which is used (with derive_public_revocation_key) to derive per-commitment
					/// revocation keys. This is combined with the per-commitment-secret generated by the
					/// counterparty to create a secret which the counterparty can reveal to revoke previous
					/// states.
					public func getRevocationBasepoint() -> [UInt8] {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisPtrPointer: UnsafePointer<LDKChannelPublicKeys>) in
				ChannelPublicKeys_get_revocation_basepoint(thisPtrPointer)
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = PublicKey(cType: nativeCallResult, anchor: self).getValue()
						

						return returnValue
					}
		
					/// The base point which is used (with derive_public_revocation_key) to derive per-commitment
					/// revocation keys. This is combined with the per-commitment-secret generated by the
					/// counterparty to create a secret which the counterparty can reveal to revoke previous
					/// states.
					public func setRevocationBasepoint(val: [UInt8]) {
						// native call variable prep
						
						let valPrimitiveWrapper = PublicKey(value: val)
				

						// native method call
						let nativeCallResult = 
						withUnsafeMutablePointer(to: &self.cType!) { (thisPtrPointer: UnsafeMutablePointer<LDKChannelPublicKeys>) in
				ChannelPublicKeys_set_revocation_basepoint(thisPtrPointer, valPrimitiveWrapper.cType!)
						}
				

						// cleanup
						
						// for elided types, we need this
						valPrimitiveWrapper.noOpRetain()
				

						
						// return value (do some wrapping)
						let returnValue = nativeCallResult
						

						return returnValue
					}
		
					/// The public key on which the non-broadcaster (ie the countersignatory) receives an immediately
					/// spendable primary channel balance on the broadcaster's commitment transaction. This key is
					/// static across every commitment transaction.
					public func getPaymentPoint() -> [UInt8] {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisPtrPointer: UnsafePointer<LDKChannelPublicKeys>) in
				ChannelPublicKeys_get_payment_point(thisPtrPointer)
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = PublicKey(cType: nativeCallResult, anchor: self).getValue()
						

						return returnValue
					}
		
					/// The public key on which the non-broadcaster (ie the countersignatory) receives an immediately
					/// spendable primary channel balance on the broadcaster's commitment transaction. This key is
					/// static across every commitment transaction.
					public func setPaymentPoint(val: [UInt8]) {
						// native call variable prep
						
						let valPrimitiveWrapper = PublicKey(value: val)
				

						// native method call
						let nativeCallResult = 
						withUnsafeMutablePointer(to: &self.cType!) { (thisPtrPointer: UnsafeMutablePointer<LDKChannelPublicKeys>) in
				ChannelPublicKeys_set_payment_point(thisPtrPointer, valPrimitiveWrapper.cType!)
						}
				

						// cleanup
						
						// for elided types, we need this
						valPrimitiveWrapper.noOpRetain()
				

						
						// return value (do some wrapping)
						let returnValue = nativeCallResult
						

						return returnValue
					}
		
					/// The base point which is used (with derive_public_key) to derive a per-commitment payment
					/// public key which receives non-HTLC-encumbered funds which are only available for spending
					/// after some delay (or can be claimed via the revocation path).
					public func getDelayedPaymentBasepoint() -> [UInt8] {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisPtrPointer: UnsafePointer<LDKChannelPublicKeys>) in
				ChannelPublicKeys_get_delayed_payment_basepoint(thisPtrPointer)
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = PublicKey(cType: nativeCallResult, anchor: self).getValue()
						

						return returnValue
					}
		
					/// The base point which is used (with derive_public_key) to derive a per-commitment payment
					/// public key which receives non-HTLC-encumbered funds which are only available for spending
					/// after some delay (or can be claimed via the revocation path).
					public func setDelayedPaymentBasepoint(val: [UInt8]) {
						// native call variable prep
						
						let valPrimitiveWrapper = PublicKey(value: val)
				

						// native method call
						let nativeCallResult = 
						withUnsafeMutablePointer(to: &self.cType!) { (thisPtrPointer: UnsafeMutablePointer<LDKChannelPublicKeys>) in
				ChannelPublicKeys_set_delayed_payment_basepoint(thisPtrPointer, valPrimitiveWrapper.cType!)
						}
				

						// cleanup
						
						// for elided types, we need this
						valPrimitiveWrapper.noOpRetain()
				

						
						// return value (do some wrapping)
						let returnValue = nativeCallResult
						

						return returnValue
					}
		
					/// The base point which is used (with derive_public_key) to derive a per-commitment public key
					/// which is used to encumber HTLC-in-flight outputs.
					public func getHtlcBasepoint() -> [UInt8] {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisPtrPointer: UnsafePointer<LDKChannelPublicKeys>) in
				ChannelPublicKeys_get_htlc_basepoint(thisPtrPointer)
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = PublicKey(cType: nativeCallResult, anchor: self).getValue()
						

						return returnValue
					}
		
					/// The base point which is used (with derive_public_key) to derive a per-commitment public key
					/// which is used to encumber HTLC-in-flight outputs.
					public func setHtlcBasepoint(val: [UInt8]) {
						// native call variable prep
						
						let valPrimitiveWrapper = PublicKey(value: val)
				

						// native method call
						let nativeCallResult = 
						withUnsafeMutablePointer(to: &self.cType!) { (thisPtrPointer: UnsafeMutablePointer<LDKChannelPublicKeys>) in
				ChannelPublicKeys_set_htlc_basepoint(thisPtrPointer, valPrimitiveWrapper.cType!)
						}
				

						// cleanup
						
						// for elided types, we need this
						valPrimitiveWrapper.noOpRetain()
				

						
						// return value (do some wrapping)
						let returnValue = nativeCallResult
						

						return returnValue
					}
		
					/// Constructs a new ChannelPublicKeys given each field
					public init(fundingPubkeyArg: [UInt8], revocationBasepointArg: [UInt8], paymentPointArg: [UInt8], delayedPaymentBasepointArg: [UInt8], htlcBasepointArg: [UInt8]) {
						// native call variable prep
						
						let fundingPubkeyArgPrimitiveWrapper = PublicKey(value: fundingPubkeyArg)
				
						let revocationBasepointArgPrimitiveWrapper = PublicKey(value: revocationBasepointArg)
				
						let paymentPointArgPrimitiveWrapper = PublicKey(value: paymentPointArg)
				
						let delayedPaymentBasepointArgPrimitiveWrapper = PublicKey(value: delayedPaymentBasepointArg)
				
						let htlcBasepointArgPrimitiveWrapper = PublicKey(value: htlcBasepointArg)
				

						// native method call
						let nativeCallResult = ChannelPublicKeys_new(fundingPubkeyArgPrimitiveWrapper.cType!, revocationBasepointArgPrimitiveWrapper.cType!, paymentPointArgPrimitiveWrapper.cType!, delayedPaymentBasepointArgPrimitiveWrapper.cType!, htlcBasepointArgPrimitiveWrapper.cType!)

						// cleanup
						
						// for elided types, we need this
						fundingPubkeyArgPrimitiveWrapper.noOpRetain()
				
						// for elided types, we need this
						revocationBasepointArgPrimitiveWrapper.noOpRetain()
				
						// for elided types, we need this
						paymentPointArgPrimitiveWrapper.noOpRetain()
				
						// for elided types, we need this
						delayedPaymentBasepointArgPrimitiveWrapper.noOpRetain()
				
						// for elided types, we need this
						htlcBasepointArgPrimitiveWrapper.noOpRetain()
				

						/*
						// return value (do some wrapping)
						let returnValue = ChannelPublicKeys(cType: nativeCallResult)
						*/

						
				self.cType = nativeCallResult

				Self.instanceCounter += 1
				self.instanceNumber = Self.instanceCounter
				super.init(conflictAvoidingVariableName: 0)
			
					}
		
					/// Creates a copy of the ChannelPublicKeys
					internal func clone() -> ChannelPublicKeys {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (origPointer: UnsafePointer<LDKChannelPublicKeys>) in
				ChannelPublicKeys_clone(origPointer)
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = ChannelPublicKeys(cType: nativeCallResult)
						

						return returnValue
					}
		
					/// Checks if two ChannelPublicKeyss contain equal inner contents.
					/// This ignores pointers and is_owned flags and looks at the values in fields.
					/// Two objects with NULL inner values will be considered "equal" here.
					public class func eq(a: ChannelPublicKeys, b: ChannelPublicKeys) -> Bool {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: a.cType!) { (aPointer: UnsafePointer<LDKChannelPublicKeys>) in
				
						withUnsafePointer(to: b.cType!) { (bPointer: UnsafePointer<LDKChannelPublicKeys>) in
				ChannelPublicKeys_eq(aPointer, bPointer)
						}
				
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = nativeCallResult
						

						return returnValue
					}
		
					/// Serialize the ChannelPublicKeys object into a byte array which can be read by ChannelPublicKeys_read
					public func write() -> [UInt8] {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (objPointer: UnsafePointer<LDKChannelPublicKeys>) in
				ChannelPublicKeys_write(objPointer)
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = Vec_u8Z(cType: nativeCallResult, anchor: self).getValue()
						

						return returnValue
					}
		
					/// Read a ChannelPublicKeys from a byte array, created by ChannelPublicKeys_write
					public class func read(ser: [UInt8]) -> Result_ChannelPublicKeysDecodeErrorZ {
						// native call variable prep
						
						let serPrimitiveWrapper = u8slice(value: ser).dangle()
				

						// native method call
						let nativeCallResult = ChannelPublicKeys_read(serPrimitiveWrapper.cType!)

						// cleanup
						
						// for elided types, we need this
						serPrimitiveWrapper.noOpRetain()
				

						
						// return value (do some wrapping)
						let returnValue = Result_ChannelPublicKeysDecodeErrorZ(cType: nativeCallResult)
						

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
		

					internal func dangle() -> ChannelPublicKeys {
						self.dangling = true
						return self
					}

					
					internal func danglingClone() -> ChannelPublicKeys {
						let dangledClone = self.clone()
						dangledClone.dangling = true
						return dangledClone
					}
			
						internal func dynamicallyDangledClone() -> ChannelPublicKeys {
							let dangledClone = self.clone()
							// if it's owned, i. e. controlled by Rust, it should dangle on our end
							dangledClone.dangling = dangledClone.cType!.is_owned
							return dangledClone
						}
					
					internal func setCFreeability(freeable: Bool) -> ChannelPublicKeys {
						self.cType!.is_owned = freeable
						return self
					}

					internal func dynamicDangle() -> ChannelPublicKeys {
						self.dangling = self.cType!.is_owned
						return self
					}
			
					deinit {
						if Bindings.suspendFreedom {
							return
						}

						if !self.dangling {
							Bindings.print("Freeing ChannelPublicKeys \(self.instanceNumber).")
							
							self.free()
						} else {
							Bindings.print("Not freeing ChannelPublicKeys \(self.instanceNumber) due to dangle.")
						}
					}
			

				}

				
			}
		
		