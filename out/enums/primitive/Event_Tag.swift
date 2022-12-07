
			#if SWIFT_PACKAGE
			import LDKHeaders
			#endif

			public typealias Event_Tag = Bindings.Event_Tag

			extension Bindings {

				/// An Event which you should probably take some action in response to.
				/// 
				/// Note that while Writeable and Readable are implemented for Event, you probably shouldn't use
				/// them directly as they don't round-trip exactly (for example FundingGenerationReady is never
				/// written as it makes no sense to respond to it after reconnecting to peers).
				public enum Event_Tag {

					
					/// Used to indicate that the client should generate a funding transaction with the given
					/// parameters and then call [`ChannelManager::funding_transaction_generated`].
					/// Generated in [`ChannelManager`] message handling.
					/// Note that *all inputs* in the funding transaction must spend SegWit outputs or your
					/// counterparty can steal your funds!
					/// 
					/// [`ChannelManager`]: crate::ln::channelmanager::ChannelManager
					/// [`ChannelManager::funding_transaction_generated`]: crate::ln::channelmanager::ChannelManager::funding_transaction_generated
					case LDKEvent_FundingGenerationReady
			
					/// Indicates we've received (an offer of) money! Just gotta dig out that payment preimage and
					/// feed it to [`ChannelManager::claim_funds`] to get it....
					/// 
					/// Note that if the preimage is not known, you should call
					/// [`ChannelManager::fail_htlc_backwards`] to free up resources for this HTLC and avoid
					/// network congestion.
					/// If you fail to call either [`ChannelManager::claim_funds`] or
					/// [`ChannelManager::fail_htlc_backwards`] within the HTLC's timeout, the HTLC will be
					/// automatically failed.
					/// 
					/// # Note
					/// LDK will not stop an inbound payment from being paid multiple times, so multiple
					/// `PaymentReceived` events may be generated for the same payment.
					/// 
					/// [`ChannelManager::claim_funds`]: crate::ln::channelmanager::ChannelManager::claim_funds
					/// [`ChannelManager::fail_htlc_backwards`]: crate::ln::channelmanager::ChannelManager::fail_htlc_backwards
					case LDKEvent_PaymentReceived
			
					/// Indicates a payment has been claimed and we've received money!
					/// 
					/// This most likely occurs when [`ChannelManager::claim_funds`] has been called in response
					/// to an [`Event::PaymentReceived`]. However, if we previously crashed during a
					/// [`ChannelManager::claim_funds`] call you may see this event without a corresponding
					/// [`Event::PaymentReceived`] event.
					/// 
					/// # Note
					/// LDK will not stop an inbound payment from being paid multiple times, so multiple
					/// `PaymentReceived` events may be generated for the same payment. If you then call
					/// [`ChannelManager::claim_funds`] twice for the same [`Event::PaymentReceived`] you may get
					/// multiple `PaymentClaimed` events.
					/// 
					/// [`ChannelManager::claim_funds`]: crate::ln::channelmanager::ChannelManager::claim_funds
					case LDKEvent_PaymentClaimed
			
					/// Indicates an outbound payment we made succeeded (i.e. it made it all the way to its target
					/// and we got back the payment preimage for it).
					/// 
					/// Note for MPP payments: in rare cases, this event may be preceded by a `PaymentPathFailed`
					/// event. In this situation, you SHOULD treat this payment as having succeeded.
					case LDKEvent_PaymentSent
			
					/// Indicates an outbound payment failed. Individual [`Event::PaymentPathFailed`] events
					/// provide failure information for each MPP part in the payment.
					/// 
					/// This event is provided once there are no further pending HTLCs for the payment and the
					/// payment is no longer retryable, either due to a several-block timeout or because
					/// [`ChannelManager::abandon_payment`] was previously called for the corresponding payment.
					/// 
					/// [`ChannelManager::abandon_payment`]: crate::ln::channelmanager::ChannelManager::abandon_payment
					case LDKEvent_PaymentFailed
			
					/// Indicates that a path for an outbound payment was successful.
					/// 
					/// Always generated after [`Event::PaymentSent`] and thus useful for scoring channels. See
					/// [`Event::PaymentSent`] for obtaining the payment preimage.
					case LDKEvent_PaymentPathSuccessful
			
					/// Indicates an outbound HTLC we sent failed. Probably some intermediary node dropped
					/// something. You may wish to retry with a different route.
					/// 
					/// Note that this does *not* indicate that all paths for an MPP payment have failed, see
					/// [`Event::PaymentFailed`] and [`all_paths_failed`].
					/// 
					/// [`all_paths_failed`]: Self::PaymentPathFailed::all_paths_failed
					case LDKEvent_PaymentPathFailed
			
					/// Indicates that a probe payment we sent returned successful, i.e., only failed at the destination.
					case LDKEvent_ProbeSuccessful
			
					/// Indicates that a probe payment we sent failed at an intermediary node on the path.
					case LDKEvent_ProbeFailed
			
					/// Used to indicate that [`ChannelManager::process_pending_htlc_forwards`] should be called at
					/// a time in the future.
					/// 
					/// [`ChannelManager::process_pending_htlc_forwards`]: crate::ln::channelmanager::ChannelManager::process_pending_htlc_forwards
					case LDKEvent_PendingHTLCsForwardable
			
					/// Used to indicate that an output which you should know how to spend was confirmed on chain
					/// and is now spendable.
					/// Such an output will *not* ever be spent by rust-lightning, and are not at risk of your
					/// counterparty spending them due to some kind of timeout. Thus, you need to store them
					/// somewhere and spend them when you create on-chain transactions.
					case LDKEvent_SpendableOutputs
			
					/// This event is generated when a payment has been successfully forwarded through us and a
					/// forwarding fee earned.
					case LDKEvent_PaymentForwarded
			
					/// Used to indicate that a previously opened channel with the given `channel_id` is in the
					/// process of closure.
					case LDKEvent_ChannelClosed
			
					/// Used to indicate to the user that they can abandon the funding transaction and recycle the
					/// inputs for another purpose.
					case LDKEvent_DiscardFunding
			
					/// Indicates a request to open a new channel by a peer.
					/// 
					/// To accept the request, call [`ChannelManager::accept_inbound_channel`]. To reject the
					/// request, call [`ChannelManager::force_close_without_broadcasting_txn`].
					/// 
					/// The event is only triggered when a new open channel request is received and the
					/// [`UserConfig::manually_accept_inbound_channels`] config flag is set to true.
					/// 
					/// [`ChannelManager::accept_inbound_channel`]: crate::ln::channelmanager::ChannelManager::accept_inbound_channel
					/// [`ChannelManager::force_close_without_broadcasting_txn`]: crate::ln::channelmanager::ChannelManager::force_close_without_broadcasting_txn
					/// [`UserConfig::manually_accept_inbound_channels`]: crate::util::config::UserConfig::manually_accept_inbound_channels
					case LDKEvent_OpenChannelRequest
			
					/// Indicates that the HTLC was accepted, but could not be processed when or after attempting to
					/// forward it.
					/// 
					/// Some scenarios where this event may be sent include:
					/// * Insufficient capacity in the outbound channel
					/// * While waiting to forward the HTLC, the channel it is meant to be forwarded through closes
					/// * When an unknown SCID is requested for forwarding a payment.
					/// * Claiming an amount for an MPP payment that exceeds the HTLC total
					/// * The HTLC has timed out
					/// 
					/// This event, however, does not get generated if an HTLC fails to meet the forwarding
					/// requirements (i.e. insufficient fees paid, or a CLTV that is too soon).
					case LDKEvent_HTLCHandlingFailed
			

					internal init (value: LDKEvent_Tag) {

						// TODO: remove this initial assumption somehow
						self = .LDKEvent_HTLCHandlingFailed

						
						if value == LDKEvent_FundingGenerationReady {
							self = .LDKEvent_FundingGenerationReady
						}
			
						if value == LDKEvent_PaymentReceived {
							self = .LDKEvent_PaymentReceived
						}
			
						if value == LDKEvent_PaymentClaimed {
							self = .LDKEvent_PaymentClaimed
						}
			
						if value == LDKEvent_PaymentSent {
							self = .LDKEvent_PaymentSent
						}
			
						if value == LDKEvent_PaymentFailed {
							self = .LDKEvent_PaymentFailed
						}
			
						if value == LDKEvent_PaymentPathSuccessful {
							self = .LDKEvent_PaymentPathSuccessful
						}
			
						if value == LDKEvent_PaymentPathFailed {
							self = .LDKEvent_PaymentPathFailed
						}
			
						if value == LDKEvent_ProbeSuccessful {
							self = .LDKEvent_ProbeSuccessful
						}
			
						if value == LDKEvent_ProbeFailed {
							self = .LDKEvent_ProbeFailed
						}
			
						if value == LDKEvent_PendingHTLCsForwardable {
							self = .LDKEvent_PendingHTLCsForwardable
						}
			
						if value == LDKEvent_SpendableOutputs {
							self = .LDKEvent_SpendableOutputs
						}
			
						if value == LDKEvent_PaymentForwarded {
							self = .LDKEvent_PaymentForwarded
						}
			
						if value == LDKEvent_ChannelClosed {
							self = .LDKEvent_ChannelClosed
						}
			
						if value == LDKEvent_DiscardFunding {
							self = .LDKEvent_DiscardFunding
						}
			
						if value == LDKEvent_OpenChannelRequest {
							self = .LDKEvent_OpenChannelRequest
						}
			
						if value == LDKEvent_HTLCHandlingFailed {
							self = .LDKEvent_HTLCHandlingFailed
						}
			
					}

					internal func getCValue() -> LDKEvent_Tag {
						switch self {
							
							case .LDKEvent_FundingGenerationReady:
								return LDKEvent_FundingGenerationReady
			
							case .LDKEvent_PaymentReceived:
								return LDKEvent_PaymentReceived
			
							case .LDKEvent_PaymentClaimed:
								return LDKEvent_PaymentClaimed
			
							case .LDKEvent_PaymentSent:
								return LDKEvent_PaymentSent
			
							case .LDKEvent_PaymentFailed:
								return LDKEvent_PaymentFailed
			
							case .LDKEvent_PaymentPathSuccessful:
								return LDKEvent_PaymentPathSuccessful
			
							case .LDKEvent_PaymentPathFailed:
								return LDKEvent_PaymentPathFailed
			
							case .LDKEvent_ProbeSuccessful:
								return LDKEvent_ProbeSuccessful
			
							case .LDKEvent_ProbeFailed:
								return LDKEvent_ProbeFailed
			
							case .LDKEvent_PendingHTLCsForwardable:
								return LDKEvent_PendingHTLCsForwardable
			
							case .LDKEvent_SpendableOutputs:
								return LDKEvent_SpendableOutputs
			
							case .LDKEvent_PaymentForwarded:
								return LDKEvent_PaymentForwarded
			
							case .LDKEvent_ChannelClosed:
								return LDKEvent_ChannelClosed
			
							case .LDKEvent_DiscardFunding:
								return LDKEvent_DiscardFunding
			
							case .LDKEvent_OpenChannelRequest:
								return LDKEvent_OpenChannelRequest
			
							case .LDKEvent_HTLCHandlingFailed:
								return LDKEvent_HTLCHandlingFailed
			
						}
					}

				}

			}
		