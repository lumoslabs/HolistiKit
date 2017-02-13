import CoreLocation

extension CLAuthorizationStatus: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .notDetermined:
            return "notDetermined"
        default:
            fatalError()
        }
    }
}
