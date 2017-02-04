import Foundation

class TimeZoneProvider: TimeZoneProviding {

    var timeZone: TimeZone {
        return TimeZone.current
    }
}

protocol TimeZoneProviding {
    
    var timeZone: TimeZone { get }
}
