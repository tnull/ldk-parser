
				
			#if SWIFT_PACKAGE
			import LDKHeaders
			#endif

			/// Per-channel data used to build transactions in conjunction with the per-commitment data (CommitmentTransaction).
			/// The fields are organized by holder/counterparty.
			/// 
			/// Normally, this is converted to the broadcaster/countersignatory-organized DirectedChannelTransactionParameters
			/// before use, via the as_holder_broadcastable and as_counterparty_broadcastable functions.
			public typealias ChannelTransactionParameters = Bindings.ChannelTransactionParameters

			extension Bindings {
		

				/// Per-channel data used to build transactions in conjunction with the per-commitment data (CommitmentTransaction).
				/// The fields are organized by holder/counterparty.
				/// 
				/// Normally, this is converted to the broadcaster/countersignatory-organized DirectedChannelTransactionParameters
				/// before use, via the as_holder_broadcastable and as_counterparty_broadcastable functions.
				public class ChannelTransactionParameters: NativeTypeWrapper {

					let initialCFreeability: Bool

					
					private static var instanceCounter: UInt = 0
					internal let instanceNumber: UInt

					internal var cType: LDKChannelTransactionParameters?

					internal init(cType: LDKChannelTransactionParameters) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = cType
						self.initialCFreeability = self.cType!.is_owned
						super.init(conflictAvoidingVariableName: 0)
					}

					internal init(cType: LDKChannelTransactionParameters, anchor: NativeTypeWrapper) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = cType
						self.initialCFreeability = self.cType!.is_owned
						super.init(conflictAvoidingVariableName: 0)
						self.dangling = true
						try! self.addAnchor(anchor: anchor)
					}
		

					
					/// Frees any resources used by the ChannelTransactionParameters, if is_owned is set and inner is non-NULL.
					internal func free() {
						// native call variable prep
						

						// native method call
						let nativeCallResult = ChannelTransactionParameters_free(self.cType!)

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = nativeCallResult
						

						return returnValue
					}
		
					/// Holder public keys
					public func getHolderPubkeys() -> ChannelPublicKeys {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisPtrPointer: UnsafePointer<LDKChannelTransactionParameters>) in
				ChannelTransactionParameters_get_holder_pubkeys(thisPtrPointer)
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = ChannelPublicKeys(cType: nativeCallResult, anchor: self).dangle(false)
						

						return returnValue
					}
		
					/// Holder public keys
					public func setHolderPubkeys(val: ChannelPublicKeys) {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafeMutablePointer(to: &self.cType!) { (thisPtrPointer: UnsafeMutablePointer<LDKChannelTransactionParameters>) in
				ChannelTransactionParameters_set_holder_pubkeys(thisPtrPointer, val.dynamicallyDangledClone().cType!)
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = nativeCallResult
						

						return returnValue
					}
		
					/// The contest delay selected by the holder, which applies to counterparty-broadcast transactions
					public func getHolderSelectedContestDelay() -> UInt16 {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisPtrPointer: UnsafePointer<LDKChannelTransactionParameters>) in
				ChannelTransactionParameters_get_holder_selected_contest_delay(thisPtrPointer)
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = nativeCallResult
						

						return returnValue
					}
		
					/// The contest delay selected by the holder, which applies to counterparty-broadcast transactions
					public func setHolderSelectedContestDelay(val: UInt16) {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafeMutablePointer(to: &self.cType!) { (thisPtrPointer: UnsafeMutablePointer<LDKChannelTransactionParameters>) in
				ChannelTransactionParameters_set_holder_selected_contest_delay(thisPtrPointer, val)
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = nativeCallResult
						

						return returnValue
					}
		
					/// Whether the holder is the initiator of this channel.
					/// This is an input to the commitment number obscure factor computation.
					public func getIsOutboundFromHolder() -> Bool {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisPtrPointer: UnsafePointer<LDKChannelTransactionParameters>) in
				ChannelTransactionParameters_get_is_outbound_from_holder(thisPtrPointer)
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = nativeCallResult
						

						return returnValue
					}
		
					/// Whether the holder is the initiator of this channel.
					/// This is an input to the commitment number obscure factor computation.
					public func setIsOutboundFromHolder(val: Bool) {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafeMutablePointer(to: &self.cType!) { (thisPtrPointer: UnsafeMutablePointer<LDKChannelTransactionParameters>) in
				ChannelTransactionParameters_set_is_outbound_from_holder(thisPtrPointer, val)
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = nativeCallResult
						

						return returnValue
					}
		
					/// The late-bound counterparty channel transaction parameters.
					/// These parameters are populated at the point in the protocol where the counterparty provides them.
					/// 
					/// Note that the return value (or a relevant inner pointer) may be NULL or all-0s to represent None
					public func getCounterpartyParameters() -> CounterpartyChannelTransactionParameters? {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisPtrPointer: UnsafePointer<LDKChannelTransactionParameters>) in
				ChannelTransactionParameters_get_counterparty_parameters(thisPtrPointer)
						}
				

						// cleanup
						
				// COMMENT-DEDUCED OPTIONAL INFERENCE AND HANDLING:
				// Type group: RustStruct
				// Type: LDKCounterpartyChannelTransactionParameters
			
					if nativeCallResult.inner == nil {
						return nil
					}

					let pointerValue = UInt(bitPattern: nativeCallResult.inner)
					if pointerValue == 0 {
						return nil
					}
				

						
						// return value (do some wrapping)
						let returnValue = CounterpartyChannelTransactionParameters(cType: nativeCallResult, anchor: self).dangle(false)
						

						return returnValue
					}
		
					/// The late-bound counterparty channel transaction parameters.
					/// These parameters are populated at the point in the protocol where the counterparty provides them.
					/// 
					/// Note that val (or a relevant inner pointer) may be NULL or all-0s to represent None
					public func setCounterpartyParameters(val: CounterpartyChannelTransactionParameters) {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafeMutablePointer(to: &self.cType!) { (thisPtrPointer: UnsafeMutablePointer<LDKChannelTransactionParameters>) in
				ChannelTransactionParameters_set_counterparty_parameters(thisPtrPointer, val.dynamicallyDangledClone().cType!)
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = nativeCallResult
						

						return returnValue
					}
		
					/// The late-bound funding outpoint
					/// 
					/// Note that the return value (or a relevant inner pointer) may be NULL or all-0s to represent None
					public func getFundingOutpoint() -> OutPoint? {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisPtrPointer: UnsafePointer<LDKChannelTransactionParameters>) in
				ChannelTransactionParameters_get_funding_outpoint(thisPtrPointer)
						}
				

						// cleanup
						
				// COMMENT-DEDUCED OPTIONAL INFERENCE AND HANDLING:
				// Type group: RustStruct
				// Type: LDKOutPoint
			
					if nativeCallResult.inner == nil {
						return nil
					}

					let pointerValue = UInt(bitPattern: nativeCallResult.inner)
					if pointerValue == 0 {
						return nil
					}
				

						
						// return value (do some wrapping)
						let returnValue = OutPoint(cType: nativeCallResult, anchor: self).dangle(false)
						

						return returnValue
					}
		
					/// The late-bound funding outpoint
					/// 
					/// Note that val (or a relevant inner pointer) may be NULL or all-0s to represent None
					public func setFundingOutpoint(val: OutPoint) {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafeMutablePointer(to: &self.cType!) { (thisPtrPointer: UnsafeMutablePointer<LDKChannelTransactionParameters>) in
				ChannelTransactionParameters_set_funding_outpoint(thisPtrPointer, val.dynamicallyDangledClone().cType!)
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = nativeCallResult
						

						return returnValue
					}
		
					/// Are anchors (zero fee HTLC transaction variant) used for this channel. Boolean is
					/// serialization backwards-compatible.
					public func getOptAnchors() -> Option_NoneZ {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisPtrPointer: UnsafePointer<LDKChannelTransactionParameters>) in
				ChannelTransactionParameters_get_opt_anchors(thisPtrPointer)
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = Option_NoneZ(value: nativeCallResult)
						

						return returnValue
					}
		
					/// Are anchors (zero fee HTLC transaction variant) used for this channel. Boolean is
					/// serialization backwards-compatible.
					@available(*, deprecated, message: "This method passes the following non-cloneable, but freeable objects by value: `val`.")
					public func setOptAnchors(val: Option_NoneZ) {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafeMutablePointer(to: &self.cType!) { (thisPtrPointer: UnsafeMutablePointer<LDKChannelTransactionParameters>) in
				ChannelTransactionParameters_set_opt_anchors(thisPtrPointer, val.getCValue())
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = nativeCallResult
						

						return returnValue
					}
		
					/// Constructs a new ChannelTransactionParameters given each field
					@available(*, deprecated, message: "This method passes the following non-cloneable, but freeable objects by value: `optAnchorsArg`.")
					public init(holderPubkeysArg: ChannelPublicKeys, holderSelectedContestDelayArg: UInt16, isOutboundFromHolderArg: Bool, counterpartyParametersArg: CounterpartyChannelTransactionParameters, fundingOutpointArg: OutPoint, optAnchorsArg: Option_NoneZ) {
						// native call variable prep
						

						// native method call
						let nativeCallResult = ChannelTransactionParameters_new(holderPubkeysArg.dynamicallyDangledClone().cType!, holderSelectedContestDelayArg, isOutboundFromHolderArg, counterpartyParametersArg.dynamicallyDangledClone().cType!, fundingOutpointArg.dynamicallyDangledClone().cType!, optAnchorsArg.getCValue())

						// cleanup
						
				self.initialCFreeability = nativeCallResult.is_owned
			

						/*
						// return value (do some wrapping)
						let returnValue = ChannelTransactionParameters(cType: nativeCallResult)
						*/

						
				self.cType = nativeCallResult

				Self.instanceCounter += 1
				self.instanceNumber = Self.instanceCounter
				super.init(conflictAvoidingVariableName: 0)
			
					}
		
					/// Creates a copy of the ChannelTransactionParameters
					internal func clone() -> ChannelTransactionParameters {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (origPointer: UnsafePointer<LDKChannelTransactionParameters>) in
				ChannelTransactionParameters_clone(origPointer)
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = ChannelTransactionParameters(cType: nativeCallResult)
						

						return returnValue
					}
		
					/// Whether the late bound parameters are populated.
					public func isPopulated() -> Bool {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisArgPointer: UnsafePointer<LDKChannelTransactionParameters>) in
				ChannelTransactionParameters_is_populated(thisArgPointer)
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = nativeCallResult
						

						return returnValue
					}
		
					/// Convert the holder/counterparty parameters to broadcaster/countersignatory-organized parameters,
					/// given that the holder is the broadcaster.
					/// 
					/// self.is_populated() must be true before calling this function.
					public func asHolderBroadcastable() -> DirectedChannelTransactionParameters {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisArgPointer: UnsafePointer<LDKChannelTransactionParameters>) in
				ChannelTransactionParameters_as_holder_broadcastable(thisArgPointer)
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = DirectedChannelTransactionParameters(cType: nativeCallResult, anchor: self).dangle(false)
						

						return returnValue
					}
		
					/// Convert the holder/counterparty parameters to broadcaster/countersignatory-organized parameters,
					/// given that the counterparty is the broadcaster.
					/// 
					/// self.is_populated() must be true before calling this function.
					public func asCounterpartyBroadcastable() -> DirectedChannelTransactionParameters {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisArgPointer: UnsafePointer<LDKChannelTransactionParameters>) in
				ChannelTransactionParameters_as_counterparty_broadcastable(thisArgPointer)
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = DirectedChannelTransactionParameters(cType: nativeCallResult, anchor: self).dangle(false)
						

						return returnValue
					}
		
					/// Serialize the ChannelTransactionParameters object into a byte array which can be read by ChannelTransactionParameters_read
					public func write() -> [UInt8] {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (objPointer: UnsafePointer<LDKChannelTransactionParameters>) in
				ChannelTransactionParameters_write(objPointer)
						}
				

						// cleanup
						

						
						// return value (do some wrapping)
						let returnValue = Vec_u8Z(cType: nativeCallResult, anchor: self).dangle(false).getValue()
						

						return returnValue
					}
		
					/// Read a ChannelTransactionParameters from a byte array, created by ChannelTransactionParameters_write
					public class func read(ser: [UInt8]) -> Result_ChannelTransactionParametersDecodeErrorZ {
						// native call variable prep
						
						let serPrimitiveWrapper = u8slice(value: ser)
				

						// native method call
						let nativeCallResult = ChannelTransactionParameters_read(serPrimitiveWrapper.cType!)

						// cleanup
						
						// for elided types, we need this
						serPrimitiveWrapper.noOpRetain()
				

						
						// return value (do some wrapping)
						let returnValue = Result_ChannelTransactionParametersDecodeErrorZ(cType: nativeCallResult)
						

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
		

					internal func dangle(_ shouldDangle: Bool = true) -> ChannelTransactionParameters {
						self.dangling = shouldDangle
						return self
					}

					
					internal func danglingClone() -> ChannelTransactionParameters {
						let dangledClone = self.clone()
						dangledClone.dangling = true
						return dangledClone
					}
			
						internal func dynamicallyDangledClone() -> ChannelTransactionParameters {
							let dangledClone = self.clone()
							// if it's owned, i. e. controlled by Rust, it should dangle on our end
							dangledClone.dangling = dangledClone.cType!.is_owned
							return dangledClone
						}
					
					internal func setCFreeability(freeable: Bool) -> ChannelTransactionParameters {
						self.cType!.is_owned = freeable
						return self
					}

					internal func dynamicDangle() -> ChannelTransactionParameters {
						self.dangling = self.cType!.is_owned
						return self
					}
			
					deinit {
						if Bindings.suspendFreedom {
							return
						}

						if !self.dangling {
							Bindings.print("Freeing ChannelTransactionParameters \(self.instanceNumber).")
							
							self.free()
						} else {
							Bindings.print("Not freeing ChannelTransactionParameters \(self.instanceNumber) due to dangle.")
						}
					}
			

				}

				
			}
		
		