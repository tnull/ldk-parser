
			#if SWIFT_PACKAGE
			import LDKHeaders
			#endif

			public typealias SpendableOutputDescriptor_Tag = Bindings.SpendableOutputDescriptor_Tag

			extension Bindings {

				/// When on-chain outputs are created by rust-lightning (which our counterparty is not able to
				/// claim at any point in the future) an event is generated which you must track and be able to
				/// spend on-chain. The information needed to do this is provided in this enum, including the
				/// outpoint describing which txid and output index is available, the full output which exists at
				/// that txid/index, and any keys or other information required to sign.
				public enum SpendableOutputDescriptor_Tag {

					
					/// An output to a script which was provided via KeysInterface directly, either from
					/// `get_destination_script()` or `get_shutdown_scriptpubkey()`, thus you should already know
					/// how to spend it. No secret keys are provided as rust-lightning was never given any key.
					/// These may include outputs from a transaction punishing our counterparty or claiming an HTLC
					/// on-chain using the payment preimage or after it has timed out.
					case LDKSpendableOutputDescriptor_StaticOutput
			
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
					case LDKSpendableOutputDescriptor_DelayedPaymentOutput
			
					/// An output to a P2WPKH, spendable exclusively by our payment key (ie the private key which
					/// corresponds to the public key in Sign::pubkeys().payment_point).
					/// The witness in the spending input, is, thus, simply:
					/// <BIP 143 signature> <payment key>
					/// 
					/// These are generally the result of our counterparty having broadcast the current state,
					/// allowing us to claim the non-HTLC-encumbered outputs immediately.
					case LDKSpendableOutputDescriptor_StaticPaymentOutput
			

					internal init (value: LDKSpendableOutputDescriptor_Tag) {

						// TODO: remove this initial assumption somehow
						self = .LDKSpendableOutputDescriptor_StaticPaymentOutput

						
						if value == LDKSpendableOutputDescriptor_StaticOutput {
							self = .LDKSpendableOutputDescriptor_StaticOutput
						}
			
						if value == LDKSpendableOutputDescriptor_DelayedPaymentOutput {
							self = .LDKSpendableOutputDescriptor_DelayedPaymentOutput
						}
			
						if value == LDKSpendableOutputDescriptor_StaticPaymentOutput {
							self = .LDKSpendableOutputDescriptor_StaticPaymentOutput
						}
			
					}

					internal func getCValue() -> LDKSpendableOutputDescriptor_Tag {
						switch self {
							
							case .LDKSpendableOutputDescriptor_StaticOutput:
								return LDKSpendableOutputDescriptor_StaticOutput
			
							case .LDKSpendableOutputDescriptor_DelayedPaymentOutput:
								return LDKSpendableOutputDescriptor_DelayedPaymentOutput
			
							case .LDKSpendableOutputDescriptor_StaticPaymentOutput:
								return LDKSpendableOutputDescriptor_StaticPaymentOutput
			
						}
					}

				}

			}
		