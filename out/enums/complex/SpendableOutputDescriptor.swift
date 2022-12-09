
			#if SWIFT_PACKAGE
			import LDKHeaders
			#endif

			/// 
			public typealias SpendableOutputDescriptor = Bindings.SpendableOutputDescriptor

			extension Bindings {

				/// When on-chain outputs are created by rust-lightning (which our counterparty is not able to
				/// claim at any point in the future) an event is generated which you must track and be able to
				/// spend on-chain. The information needed to do this is provided in this enum, including the
				/// outpoint describing which txid and output index is available, the full output which exists at
				/// that txid/index, and any keys or other information required to sign.
				public class SpendableOutputDescriptor: NativeTypeWrapper {

					
					private static var instanceCounter: UInt = 0
					internal let instanceNumber: UInt

					internal var cType: LDKSpendableOutputDescriptor?

					public init(cType: LDKSpendableOutputDescriptor) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = cType
						super.init(conflictAvoidingVariableName: 0)
					}

					public init(cType: LDKSpendableOutputDescriptor, anchor: NativeTypeWrapper) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = cType
						super.init(conflictAvoidingVariableName: 0)
						self.dangling = true
						try! self.addAnchor(anchor: anchor)
					}
		

					public enum SpendableOutputDescriptorType {
						
						/// An output to a script which was provided via KeysInterface directly, either from
						/// `get_destination_script()` or `get_shutdown_scriptpubkey()`, thus you should already know
						/// how to spend it. No secret keys are provided as rust-lightning was never given any key.
						/// These may include outputs from a transaction punishing our counterparty or claiming an HTLC
						/// on-chain using the payment preimage or after it has timed out.
						case StaticOutput
			
						/// An output to a P2WSH script which can be spent with a single signature after a CSV delay.
						/// 
						/// The witness in the spending input should be:
						/// <BIP 143 signature> <empty vector> (MINIMALIF standard rule) <provided witnessScript>
						/// 
						/// Note that the nSequence field in the spending input must be set to to_self_delay
						/// (which means the transaction is not broadcastable until at least to_self_delay
						/// blocks after the outpoint confirms).
						/// 
						/// These are generally the result of a \"revocable\" output to us, spendable only by us unless
						/// it is an output from an old state which we broadcast (which should never happen).
						/// 
						/// To derive the delayed_payment key which is used to sign for this input, you must pass the
						/// holder delayed_payment_base_key (ie the private key which corresponds to the pubkey in
						/// Sign::pubkeys().delayed_payment_basepoint) and the provided per_commitment_point to
						/// chan_utils::derive_private_key. The public key can be generated without the secret key
						/// using chan_utils::derive_public_key and only the delayed_payment_basepoint which appears in
						/// Sign::pubkeys().
						/// 
						/// To derive the revocation_pubkey provided here (which is used in the witness
						/// script generation), you must pass the counterparty revocation_basepoint (which appears in the
						/// call to Sign::ready_channel) and the provided per_commitment point
						/// to chan_utils::derive_public_revocation_key.
						/// 
						/// The witness script which is hashed and included in the output script_pubkey may be
						/// regenerated by passing the revocation_pubkey (derived as above), our delayed_payment pubkey
						/// (derived as above), and the to_self_delay contained here to
						/// chan_utils::get_revokeable_redeemscript.
						case DelayedPaymentOutput
			
						/// An output to a P2WPKH, spendable exclusively by our payment key (ie the private key which
						/// corresponds to the public key in Sign::pubkeys().payment_point).
						/// The witness in the spending input, is, thus, simply:
						/// <BIP 143 signature> <payment key>
						/// 
						/// These are generally the result of our counterparty having broadcast the current state,
						/// allowing us to claim the non-HTLC-encumbered outputs immediately.
						case StaticPaymentOutput
			
					}

					public func getValueType() -> SpendableOutputDescriptorType? {
						switch self.cType!.tag {
							case LDKSpendableOutputDescriptor_StaticOutput:
								return .StaticOutput
			
							case LDKSpendableOutputDescriptor_DelayedPaymentOutput:
								return .DelayedPaymentOutput
			
							case LDKSpendableOutputDescriptor_StaticPaymentOutput:
								return .StaticPaymentOutput
			
							default:
								return nil
						}
		
					}

					
					/// Frees any resources used by the SpendableOutputDescriptor
					internal func free() {
						// native call variable prep
						

						// native method call
						let nativeCallResult = SpendableOutputDescriptor_free(self.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Creates a copy of the SpendableOutputDescriptor
					internal func clone() -> SpendableOutputDescriptor {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (origPointer: UnsafePointer<LDKSpendableOutputDescriptor>) in
				SpendableOutputDescriptor_clone(origPointer)
						}
				

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = SpendableOutputDescriptor(cType: nativeCallResult)

						return returnValue
					}
		
					/// Utility method to constructs a new StaticOutput-variant SpendableOutputDescriptor
					public class func initWithStaticOutput(outpoint: Bindings.OutPoint, output: Bindings.TxOut) -> SpendableOutputDescriptor {
						// native call variable prep
						

						// native method call
						let nativeCallResult = SpendableOutputDescriptor_static_output(outpoint.cType!, output.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = SpendableOutputDescriptor(cType: nativeCallResult)

						return returnValue
					}
		
					/// Utility method to constructs a new DelayedPaymentOutput-variant SpendableOutputDescriptor
					public class func initWithDelayedPaymentOutput(a: Bindings.DelayedPaymentOutputDescriptor) -> SpendableOutputDescriptor {
						// native call variable prep
						

						// native method call
						let nativeCallResult = SpendableOutputDescriptor_delayed_payment_output(a.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = SpendableOutputDescriptor(cType: nativeCallResult)

						return returnValue
					}
		
					/// Utility method to constructs a new StaticPaymentOutput-variant SpendableOutputDescriptor
					public class func initWithStaticPaymentOutput(a: Bindings.StaticPaymentOutputDescriptor) -> SpendableOutputDescriptor {
						// native call variable prep
						

						// native method call
						let nativeCallResult = SpendableOutputDescriptor_static_payment_output(a.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = SpendableOutputDescriptor(cType: nativeCallResult)

						return returnValue
					}
		
					/// Checks if two SpendableOutputDescriptors contain equal inner contents.
					/// This ignores pointers and is_owned flags and looks at the values in fields.
					public func eq() -> Bool {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (aPointer: UnsafePointer<LDKSpendableOutputDescriptor>) in
				
						withUnsafePointer(to: self.cType!) { (bPointer: UnsafePointer<LDKSpendableOutputDescriptor>) in
				SpendableOutputDescriptor_eq(aPointer, bPointer)
						}
				
						}
				

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Serialize the SpendableOutputDescriptor object into a byte array which can be read by SpendableOutputDescriptor_read
					public func write() -> [UInt8] {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (objPointer: UnsafePointer<LDKSpendableOutputDescriptor>) in
				SpendableOutputDescriptor_write(objPointer)
						}
				

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = Vec_u8Z(cType: nativeCallResult).getValue()

						return returnValue
					}
		
					/// Read a SpendableOutputDescriptor from a byte array, created by SpendableOutputDescriptor_write
					public class func read(ser: [UInt8]) -> Result_SpendableOutputDescriptorDecodeErrorZ {
						// native call variable prep
						
						let serPrimitiveWrapper = u8slice(value: ser)
				

						// native method call
						let nativeCallResult = SpendableOutputDescriptor_read(serPrimitiveWrapper.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = Result_SpendableOutputDescriptorDecodeErrorZ(cType: nativeCallResult)

						return returnValue
					}
		

					
					public func getValueAsStaticOutput() -> StaticOutput? {
						if self.cType?.tag != LDKSpendableOutputDescriptor_StaticOutput {
							return nil
						}

						return SpendableOutputDescriptor_LDKStaticOutput_Body(cType: self.cType!.static_output, anchor: self).dangle()
					}
			
					public func getValueAsDelayedPaymentOutput() -> Bindings.DelayedPaymentOutputDescriptor? {
						if self.cType?.tag != LDKSpendableOutputDescriptor_DelayedPaymentOutput {
							return nil
						}

						return DelayedPaymentOutputDescriptor(cType: self.cType!.delayed_payment_output, anchor: self).dangle()
					}
			
					public func getValueAsStaticPaymentOutput() -> Bindings.StaticPaymentOutputDescriptor? {
						if self.cType?.tag != LDKSpendableOutputDescriptor_StaticPaymentOutput {
							return nil
						}

						return StaticPaymentOutputDescriptor(cType: self.cType!.static_payment_output, anchor: self).dangle()
					}
			

					internal func dangle() -> SpendableOutputDescriptor {
        				self.dangling = true
						return self
					}

					
					internal func danglingClone() -> SpendableOutputDescriptor {
						let dangledClone = self.clone()
						dangledClone.dangling = true
						return dangledClone
					}
			
					deinit {
						if !self.dangling {
							Bindings.print("Freeing SpendableOutputDescriptor \(self.instanceNumber).")
							self.free()
						} else {
							Bindings.print("Not freeing SpendableOutputDescriptor \(self.instanceNumber) due to dangle.")
						}
					}
			

					
					
					/// 
					internal typealias SpendableOutputDescriptor_LDKStaticOutput_Body = StaticOutput
			

					/// 
					public class StaticOutput: NativeTypeWrapper {

						
						private static var instanceCounter: UInt = 0
						internal let instanceNumber: UInt

						internal var cType: LDKSpendableOutputDescriptor_LDKStaticOutput_Body?

						fileprivate init(cType: LDKSpendableOutputDescriptor_LDKStaticOutput_Body) {
							Self.instanceCounter += 1
							self.instanceNumber = Self.instanceCounter
							self.cType = cType
							super.init(conflictAvoidingVariableName: 0)
						}

						fileprivate init(cType: LDKSpendableOutputDescriptor_LDKStaticOutput_Body, anchor: NativeTypeWrapper) {
							Self.instanceCounter += 1
							self.instanceNumber = Self.instanceCounter
							self.cType = cType
							super.init(conflictAvoidingVariableName: 0)
							self.dangling = true
							try! self.addAnchor(anchor: anchor)
						}
		

						

						
						/// The outpoint which is spendable
						public func getOutpoint() -> Bindings.OutPoint {
							// return value (do some wrapping)
							let returnValue = Bindings.OutPoint(cType: self.cType!.outpoint, anchor: self).dangle()

							return returnValue;
						}
		
						/// The output which is referenced by the given outpoint.
						public func getOutput() -> Bindings.TxOut {
							// return value (do some wrapping)
							let returnValue = Bindings.TxOut(cType: self.cType!.output, anchor: self).dangle()

							return returnValue;
						}
		

						internal func dangle() -> StaticOutput {
							self.dangling = true
							return self
						}

											

					}

					
		

				}

			}
		