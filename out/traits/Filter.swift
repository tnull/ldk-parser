
			#if SWIFT_PACKAGE
			import LDKHeaders
			#endif

			public typealias Filter = Bindings.Filter

			extension Bindings {

				/// The `Filter` trait defines behavior for indicating chain activity of interest pertaining to
				/// channels.
				/// 
				/// This is useful in order to have a [`Watch`] implementation convey to a chain source which
				/// transactions to be notified of. Notification may take the form of pre-filtering blocks or, in
				/// the case of [BIP 157]/[BIP 158], only fetching a block if the compact filter matches. If
				/// receiving full blocks from a chain source, any further filtering is unnecessary.
				/// 
				/// After an output has been registered, subsequent block retrievals from the chain source must not
				/// exclude any transactions matching the new criteria nor any in-block descendants of such
				/// transactions.
				/// 
				/// Note that use as part of a [`Watch`] implementation involves reentrancy. Therefore, the `Filter`
				/// should not block on I/O. Implementations should instead queue the newly monitored data to be
				/// processed later. Then, in order to block until the data has been processed, any [`Watch`]
				/// invocation that has called the `Filter` must return [`InProgress`].
				/// 
				/// [`InProgress`]: ChannelMonitorUpdateStatus::InProgress
				/// [BIP 157]: https://github.com/bitcoin/bips/blob/master/bip-0157.mediawiki
				/// [BIP 158]: https://github.com/bitcoin/bips/blob/master/bip-0158.mediawiki
				open class Filter: NativeTraitWrapper {

					
					private static var instanceCounter: UInt = 0
					internal let instanceNumber: UInt

					internal var cType: LDKFilter?

					public init(pointer: LDKFilter) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = pointer
						super.init(conflictAvoidingVariableName: 0)
					}

					public init(pointer: LDKFilter, anchor: NativeTypeWrapper) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = pointer
						super.init(conflictAvoidingVariableName: 0)
						self.dangling = true
						try! self.addAnchor(anchor: anchor)
					}
		

					public init() {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter

						let thisArg = Bindings.instanceToPointer(instance: self)

						

						
						func registerTxLambda(this_arg: UnsafeRawPointer?, txid: UnsafePointer<UInt8Tuple32>?, script_pubkey: LDKu8slice) -> Void {
							let instance: Filter = Bindings.pointerToInstance(pointer: this_arg!, sourceMarker: "Filter::registerTxLambda")

							// Swift callback variable prep
							
							var txidPointee: UInt8Tuple32? = nil
							if let txidUnwrapped = txid {
								txidPointee = Bindings.UInt8Tuple32ToArray(tuple: txidUnwrapped.pointee)
							}
						

							// Swift callback call
							let swiftCallbackResult = instance.registerTx(txid: txidPointee, scriptPubkey: u8slice(pointer: script_pubkey).getValue())

							// cleanup
							

							// return value (do some wrapping)
							let returnValue = swiftCallbackResult

							return returnValue
						}
		
						func registerOutputLambda(this_arg: UnsafeRawPointer?, output: LDKWatchedOutput) -> Void {
							let instance: Filter = Bindings.pointerToInstance(pointer: this_arg!, sourceMarker: "Filter::registerOutputLambda")

							// Swift callback variable prep
											

							// Swift callback call
							let swiftCallbackResult = instance.registerOutput(output: WatchedOutput(pointer: output))

							// cleanup
							

							// return value (do some wrapping)
							let returnValue = swiftCallbackResult

							return returnValue
						}
		
						func freeLambda(this_arg: UnsafeMutableRawPointer?) -> Void {
							let instance: Filter = Bindings.pointerToInstance(pointer: this_arg!, sourceMarker: "Filter::freeLambda")

							// Swift callback variable prep
											

							// Swift callback call
							let swiftCallbackResult = instance.free()

							// cleanup
							

							// return value (do some wrapping)
							let returnValue = swiftCallbackResult

							return returnValue
						}
		

						self.cType = LDKFilter(							
							this_arg: thisArg,
							register_tx: registerTxLambda,
							register_output: registerOutputLambda,
							free: freeLambda
						)

						super.init(conflictAvoidingVariableName: 0)
					}

					
					/// Registers interest in a transaction with `txid` and having an output with `script_pubkey` as
					/// a spending condition.
					open func registerTx(txid: [UInt8], scriptPubkey: [UInt8]) -> Void {
						Bindings.print("Error: Filter::registerTx MUST be overridden! Offending class: (String(describing: self)). Aborting.", severity: .ERROR)
						abort()
					}
		
					/// Registers interest in spends of a transaction output.
					/// 
					/// Note that this method might be called during processing of a new block. You therefore need
					/// to ensure that also dependent output spents within an already connected block are correctly
					/// handled, e.g., by re-scanning the block in question whenever new outputs have been
					/// registered mid-processing.
					open func registerOutput(output: WatchedOutput) -> Void {
						Bindings.print("Error: Filter::registerOutput MUST be overridden! Offending class: (String(describing: self)). Aborting.", severity: .ERROR)
						abort()
					}
		
					/// Frees any resources associated with this object given its this_arg pointer.
					/// Does not need to free the outer struct containing function pointers and may be NULL is no resources need to be freed.
					open func free() -> Void {
						Bindings.print("Error: Filter::free MUST be overridden! Offending class: (String(describing: self)). Aborting.", severity: .ERROR)
						abort()
					}
		

					
					/// Calls the free function if one is set
					internal func free() {
						// native call variable prep
						

						// native method call
						let nativeCallResult = Filter_free(self.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		

					

					internal func dangle() -> Filter {
        				self.dangling = true
						return self
					}

					deinit {
						if !self.dangling {
							Bindings.print("Freeing Filter \(self.instanceNumber).")
							self.free()
						} else {
							Bindings.print("Not freeing Filter \(self.instanceNumber) due to dangle.")
						}
					}
				}

				public class NativelyImplementedFilter: Filter {
					
					/// Registers interest in a transaction with `txid` and having an output with `script_pubkey` as
					/// a spending condition.
					public func registerTx(txid: [UInt8]?, scriptPubkey: [UInt8]) {
						// native call variable prep
						
						let tupledTxid = Bindings.arrayToUInt8Tuple32(array: txid)
					

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: tupledTxid) { (tupledTxidPointer: UnsafePointer<UInt8Tuple32>) in
			self.cType!.register_tx(self.cType!.this_arg, tupledTxidPointer, scriptPubkey.cType!)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Registers interest in spends of a transaction output.
					/// 
					/// Note that this method might be called during processing of a new block. You therefore need
					/// to ensure that also dependent output spents within an already connected block are correctly
					/// handled, e.g., by re-scanning the block in question whenever new outputs have been
					/// registered mid-processing.
					public func registerOutput(output: WatchedOutput) {
						// native call variable prep
						

						// native method call
						let nativeCallResult = self.cType!.register_output(self.cType!.this_arg, output.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Frees any resources associated with this object given its this_arg pointer.
					/// Does not need to free the outer struct containing function pointers and may be NULL is no resources need to be freed.
					public func free() {
						// native call variable prep
						

						// native method call
						let nativeCallResult = self.cType!.free(self.cType!.this_arg)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
				}

			}
		