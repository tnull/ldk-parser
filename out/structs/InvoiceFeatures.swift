
				
			#if SWIFT_PACKAGE
			import LDKHeaders
			#endif

			public typealias InvoiceFeatures = Bindings.InvoiceFeatures

			extension Bindings {
		

				/// Features used within an invoice.
				public class InvoiceFeatures: NativeTypeWrapper {

					
					private static var instanceCounter: UInt = 0
					internal let instanceNumber: UInt

					internal var cType: LDKInvoiceFeatures?

					public init(pointer: LDKInvoiceFeatures) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = pointer
						super.init(conflictAvoidingVariableName: 0)
					}

					public init(pointer: LDKInvoiceFeatures, anchor: NativeTypeWrapper) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = pointer
						super.init(conflictAvoidingVariableName: 0)
						self.dangling = true
						try! self.addAnchor(anchor: anchor)
					}
		

					
					/// Checks if two InvoiceFeaturess contain equal inner contents.
					/// This ignores pointers and is_owned flags and looks at the values in fields.
					/// Two objects with NULL inner values will be considered "equal" here.
					public func eq() -> Bool {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (aPointer: UnsafePointer<LDKInvoiceFeatures>) in
			
						withUnsafePointer(to: self.cType!) { (bPointer: UnsafePointer<LDKInvoiceFeatures>) in
			InvoiceFeatures_eq(aPointer, bPointer)
						}
			
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Creates a copy of the InvoiceFeatures
					internal func clone() -> InvoiceFeatures {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (origPointer: UnsafePointer<LDKInvoiceFeatures>) in
			InvoiceFeatures_clone(origPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = InvoiceFeatures(pointer: nativeCallResult)

						return returnValue
					}
		
					/// Frees any resources used by the InvoiceFeatures, if is_owned is set and inner is non-NULL.
					internal func free() {
						// native call variable prep
						

						// native method call
						let nativeCallResult = InvoiceFeatures_free(self.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Create a blank Features with no features set
					public init() {
						// native call variable prep
						

						// native method call
						let nativeCallResult = InvoiceFeatures_empty()

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = InvoiceFeatures(pointer: nativeCallResult)

						self.cType = nativeCallResult
					}
		
					/// Returns true if this `Features` object contains unknown feature flags which are set as
					/// \"required\".
					public func requiresUnknownBits() -> Bool {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisArgPointer: UnsafePointer<LDKInvoiceFeatures>) in
			InvoiceFeatures_requires_unknown_bits(thisArgPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Serialize the InvoiceFeatures object into a byte array which can be read by InvoiceFeatures_read
					public func write() -> [UInt8] {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (objPointer: UnsafePointer<LDKInvoiceFeatures>) in
			InvoiceFeatures_write(objPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = Vec_u8Z(pointer: nativeCallResult).getValue()

						return returnValue
					}
		
					/// Read a InvoiceFeatures from a byte array, created by InvoiceFeatures_write
					public class func read(ser: [UInt8]) -> Result_InvoiceFeaturesDecodeErrorZ {
						// native call variable prep
						

						// native method call
						let nativeCallResult = InvoiceFeatures_read(ser.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = Result_InvoiceFeaturesDecodeErrorZ(pointer: nativeCallResult)

						return returnValue
					}
		
					/// Set this feature as optional.
					public func setVariableLengthOnionOptional() {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisArgPointer: UnsafePointer<LDKInvoiceFeatures>) in
			InvoiceFeatures_set_variable_length_onion_optional(thisArgPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Set this feature as required.
					public func setVariableLengthOnionRequired() {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisArgPointer: UnsafePointer<LDKInvoiceFeatures>) in
			InvoiceFeatures_set_variable_length_onion_required(thisArgPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Checks if this feature is supported.
					public func supportsVariableLengthOnion() -> Bool {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisArgPointer: UnsafePointer<LDKInvoiceFeatures>) in
			InvoiceFeatures_supports_variable_length_onion(thisArgPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Checks if this feature is required.
					public func requiresVariableLengthOnion() -> Bool {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisArgPointer: UnsafePointer<LDKInvoiceFeatures>) in
			InvoiceFeatures_requires_variable_length_onion(thisArgPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Set this feature as optional.
					public func setPaymentSecretOptional() {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisArgPointer: UnsafePointer<LDKInvoiceFeatures>) in
			InvoiceFeatures_set_payment_secret_optional(thisArgPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Set this feature as required.
					public func setPaymentSecretRequired() {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisArgPointer: UnsafePointer<LDKInvoiceFeatures>) in
			InvoiceFeatures_set_payment_secret_required(thisArgPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Checks if this feature is supported.
					public func supportsPaymentSecret() -> Bool {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisArgPointer: UnsafePointer<LDKInvoiceFeatures>) in
			InvoiceFeatures_supports_payment_secret(thisArgPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Checks if this feature is required.
					public func requiresPaymentSecret() -> Bool {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisArgPointer: UnsafePointer<LDKInvoiceFeatures>) in
			InvoiceFeatures_requires_payment_secret(thisArgPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Set this feature as optional.
					public func setBasicMppOptional() {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisArgPointer: UnsafePointer<LDKInvoiceFeatures>) in
			InvoiceFeatures_set_basic_mpp_optional(thisArgPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Set this feature as required.
					public func setBasicMppRequired() {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisArgPointer: UnsafePointer<LDKInvoiceFeatures>) in
			InvoiceFeatures_set_basic_mpp_required(thisArgPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Checks if this feature is supported.
					public func supportsBasicMpp() -> Bool {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisArgPointer: UnsafePointer<LDKInvoiceFeatures>) in
			InvoiceFeatures_supports_basic_mpp(thisArgPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		
					/// Checks if this feature is required.
					public func requiresBasicMpp() -> Bool {
						// native call variable prep
						

						// native method call
						let nativeCallResult = 
						withUnsafePointer(to: self.cType!) { (thisArgPointer: UnsafePointer<LDKInvoiceFeatures>) in
			InvoiceFeatures_requires_basic_mpp(thisArgPointer)
						}
			

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

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
		

					internal func dangle() -> InvoiceFeatures {
						self.dangling = true
						return self
					}

					
					internal func danglingClone() -> InvoiceFeatures {
						let dangledClone = self.clone()
						dangledClone.dangling = true
						return dangledClone
					}
			
					deinit {
						if !self.dangling {
							Bindings.print("Freeing InvoiceFeatures \(self.instanceNumber).")
							self.free()
						} else {
							Bindings.print("Not freeing InvoiceFeatures \(self.instanceNumber) due to dangle.")
						}
					}
			

				}

				
			}
		
		