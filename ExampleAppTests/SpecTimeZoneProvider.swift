import Foundation
@testable import ExampleApp

class SpecTimeZoneProvider: TimeZoneProviding {
    
    lazy var timeZone: TimeZone = {
        return TimeZone(abbreviation: "BRT")!
    }()
}
