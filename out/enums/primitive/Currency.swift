
			#if SWIFT_PACKAGE
			import LDKHeaders
			#endif

			public typealias Currency = Bindings.Currency

			extension Bindings {

				/// Enum representing the crypto currencies (or networks) supported by this library
				public enum Currency {

					
					/// Bitcoin mainnet
					case Bitcoin
			
					/// Bitcoin testnet
					case BitcoinTestnet
			
					/// Bitcoin regtest
					case Regtest
			
					/// Bitcoin simnet
					case Simnet
			
					/// Bitcoin signet
					case Signet
			

					internal init (value: LDKCurrency) {

						// TODO: remove this initial assumption somehow
						self = .Signet

						
						// LDKCurrency_Bitcoin
						if value.rawValue == 0 {
							self = .Bitcoin
						}
			
						// LDKCurrency_BitcoinTestnet
						if value.rawValue == 1 {
							self = .BitcoinTestnet
						}
			
						// LDKCurrency_Regtest
						if value.rawValue == 2 {
							self = .Regtest
						}
			
						// LDKCurrency_Simnet
						if value.rawValue == 3 {
							self = .Simnet
						}
			
						// LDKCurrency_Signet
						if value.rawValue == 4 {
							self = .Signet
						}
			
					}

					internal func getCValue() -> LDKCurrency {
						switch self {
							
							case .Bitcoin:
								// return LDKCurrency_Bitcoin
								return LDKCurrency(0)
			
							case .BitcoinTestnet:
								// return LDKCurrency_BitcoinTestnet
								return LDKCurrency(1)
			
							case .Regtest:
								// return LDKCurrency_Regtest
								return LDKCurrency(2)
			
							case .Simnet:
								// return LDKCurrency_Simnet
								return LDKCurrency(3)
			
							case .Signet:
								// return LDKCurrency_Signet
								return LDKCurrency(4)
			
						}
					}

				}

			}
		