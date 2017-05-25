import CoreLocation

fileprivate extension CLLocationCoordinate2D {

    private var insignificantDistance: CLLocationDistance { return 0.0000001 }

    fileprivate func consideredSame(as other: CLLocationCoordinate2D?) -> Bool {
        guard let other = other else { return false }
        return asLocation.distance(from: other.asLocation) < insignificantDistance
    }

    private var asLocation: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}

extension CLLocationCoordinate2D: Equatable {}

public func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return lhs.consideredSame(as: rhs)
}
