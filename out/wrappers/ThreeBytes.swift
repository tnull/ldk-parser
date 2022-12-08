
			#if SWIFT_PACKAGE
			import LDKHeaders
			#endif

			internal typealias ThreeBytes = Bindings.ThreeBytes

			extension Bindings {

				/// A 3-byte byte array.
				internal class ThreeBytes: NativeTypeWrapper {

					
					private static var instanceCounter: UInt = 0
					internal let instanceNumber: UInt

					internal var cType: LDKThreeBytes?

					public init(cType: LDKThreeBytes) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = cType
						super.init(conflictAvoidingVariableName: 0)
					}

					public init(cType: LDKThreeBytes, anchor: NativeTypeWrapper) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter
						self.cType = cType
						super.init(conflictAvoidingVariableName: 0)
						self.dangling = true
						try! self.addAnchor(anchor: anchor)
					}
		

					public init(value: [UInt8]) {
						Self.instanceCounter += 1
						self.instanceNumber = Self.instanceCounter

						self.cType = LDKThreeBytes(data: Bindings.arrayToUInt8Tuple3(array: value))

						super.init(conflictAvoidingVariableName: 0)
					}

					

					public func getValue() -> [UInt8] {
						return Bindings.UInt8Tuple3ToArray(tuple: self.cType!.data)
					}

					internal func dangle() -> ThreeBytes {
        				self.dangling = true
						return self
					}

										

				}

			}
		