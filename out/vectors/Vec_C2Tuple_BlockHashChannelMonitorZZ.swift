
			#if SWIFT_PACKAGE
			import LDKHeaders
			#endif

			internal typealias Vec_C2Tuple_BlockHashChannelMonitorZZ = Bindings.Vec_C2Tuple_BlockHashChannelMonitorZZ

			extension Bindings {

				/// A dynamically-allocated array of crate::c_types::derived::C2Tuple_BlockHashChannelMonitorZs of arbitrary size.
				/// This corresponds to std::vector in C++
				internal class Vec_C2Tuple_BlockHashChannelMonitorZZ: NativeTypeWrapper {

					
					private static var instanceCounter: UInt = 0
					internal let instanceNumber: UInt

					internal var cType: LDKCVec_C2Tuple_BlockHashChannelMonitorZZ?

					public init(pointer: LDKCVec_C2Tuple_BlockHashChannelMonitorZZ) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = pointer
						super.init(conflictAvoidingVariableName: 0)
					}

					public init(pointer: LDKCVec_C2Tuple_BlockHashChannelMonitorZZ, anchor: NativeTypeWrapper) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = pointer
						super.init(conflictAvoidingVariableName: 0)
						self.dangling = true
						try! self.addAnchor(anchor: anchor)
					}
		

					public init(array: [([UInt8], ChannelMonitor)]) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter

						let rustArray = array.map { (currentValueDepth1) in
							currentValueDepth1.danglingClone().cType!
						}

						

						let dataContainer = UnsafeMutablePointernull.allocate(capacity: array.count)
						dataContainer.initialize(from: rustArray, count: array.count)

        				let vector = LDKCVec_C2Tuple_BlockHashChannelMonitorZZ(data: dataContainer, datalen: UInt(array.count))
        				self.cType = vector

						super.init(conflictAvoidingVariableName: 0)
					}

					public func getValue() -> [([UInt8], ChannelMonitor)] {

						var array = [LDKC2Tuple_BlockHashChannelMonitorZ]()

						
						for index1 in 0..<Int(self.cType!.datalen) {
							let currentEntry1 = self.cType!.data[index1]
							array.append(currentEntry1)
						}
		

						let swiftArray = array.map { (currentCType) in
							Tuple_BlockHashChannelMonitorZ(pointer: currentCType).getValue()
						}
						return swiftArray
					}

					
					/// Frees the buffer pointed to by `data` if `datalen` is non-0.
					internal func free() {
						// native call variable prep
						

						// native method call
						let nativeCallResult = CVec_C2Tuple_BlockHashChannelMonitorZZ_free(self.cType!)

						// cleanup
						

						// return value (do some wrapping)
						let returnValue = nativeCallResult

						return returnValue
					}
		

					internal func dangle() -> Vec_C2Tuple_BlockHashChannelMonitorZZ {
        				self.dangling = true
						return self
					}

					
					deinit {
						if !self.dangling {
							Bindings.print("Freeing Vec_C2Tuple_BlockHashChannelMonitorZZ \(self.instanceNumber).")
							self.free()
						} else {
							Bindings.print("Not freeing Vec_C2Tuple_BlockHashChannelMonitorZZ \(self.instanceNumber) due to dangle.")
						}
					}
			

				}

			}
		