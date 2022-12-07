
			#if SWIFT_PACKAGE
			import LDKHeaders
			#endif

			public typealias PaymentSendFailure_Tag = Bindings.PaymentSendFailure_Tag

			extension Bindings {

				/// If a payment fails to send, it can be in one of several states. This enum is returned as the
				/// Err() type describing which state the payment is in, see the description of individual enum
				/// states for more.
				public enum PaymentSendFailure_Tag {

					
					/// A parameter which was passed to send_payment was invalid, preventing us from attempting to
					/// send the payment at all. No channel state has been changed or messages sent to peers, and
					/// once you've changed the parameter at error, you can freely retry the payment in full.
					case LDKPaymentSendFailure_ParameterError
			
					/// A parameter in a single path which was passed to send_payment was invalid, preventing us
					/// from attempting to send the payment at all. No channel state has been changed or messages
					/// sent to peers, and once you've changed the parameter at error, you can freely retry the
					/// payment in full.
					/// 
					/// The results here are ordered the same as the paths in the route object which was passed to
					/// send_payment.
					case LDKPaymentSendFailure_PathParameterError
			
					/// All paths which were attempted failed to send, with no channel state change taking place.
					/// You can freely retry the payment in full (though you probably want to do so over different
					/// paths than the ones selected).
					case LDKPaymentSendFailure_AllFailedRetrySafe
			
					/// Some paths which were attempted failed to send, though possibly not all. At least some
					/// paths have irrevocably committed to the HTLC and retrying the payment in full would result
					/// in over-/re-payment.
					/// 
					/// The results here are ordered the same as the paths in the route object which was passed to
					/// send_payment, and any `Err`s which are not [`APIError::MonitorUpdateInProgress`] can be
					/// safely retried via [`ChannelManager::retry_payment`].
					/// 
					/// Any entries which contain `Err(APIError::MonitorUpdateInprogress)` or `Ok(())` MUST NOT be
					/// retried as they will result in over-/re-payment. These HTLCs all either successfully sent
					/// (in the case of `Ok(())`) or will send once a [`MonitorEvent::Completed`] is provided for
					/// the next-hop channel with the latest update_id.
					case LDKPaymentSendFailure_PartialFailure
			

					internal init (value: LDKPaymentSendFailure_Tag) {

						// TODO: remove this initial assumption somehow
						self = .LDKPaymentSendFailure_PartialFailure

						
						if value == LDKPaymentSendFailure_ParameterError {
							self = .LDKPaymentSendFailure_ParameterError
						}
			
						if value == LDKPaymentSendFailure_PathParameterError {
							self = .LDKPaymentSendFailure_PathParameterError
						}
			
						if value == LDKPaymentSendFailure_AllFailedRetrySafe {
							self = .LDKPaymentSendFailure_AllFailedRetrySafe
						}
			
						if value == LDKPaymentSendFailure_PartialFailure {
							self = .LDKPaymentSendFailure_PartialFailure
						}
			
					}

					internal func getCValue() -> LDKPaymentSendFailure_Tag {
						switch self {
							
							case .LDKPaymentSendFailure_ParameterError:
								return LDKPaymentSendFailure_ParameterError
			
							case .LDKPaymentSendFailure_PathParameterError:
								return LDKPaymentSendFailure_PathParameterError
			
							case .LDKPaymentSendFailure_AllFailedRetrySafe:
								return LDKPaymentSendFailure_AllFailedRetrySafe
			
							case .LDKPaymentSendFailure_PartialFailure:
								return LDKPaymentSendFailure_PartialFailure
			
						}
					}

				}

			}
		