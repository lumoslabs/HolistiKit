import Foundation
@testable import FringesExample

class SpecTimeZoneProvider: TimeZoneProviding {
    
    lazy var timeZone: TimeZone = {
        return TimeZone(abbreviation: "BRT")!
    }()
}
