import CoreLocation

extension CLLocationCoordinate2D {

    var asLocation: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}
