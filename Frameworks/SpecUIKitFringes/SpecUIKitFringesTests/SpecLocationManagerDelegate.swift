import CoreLocation
import UIKitFringes

class SpecLocationManagerDelegate: LocationManagingDelegate {

    var receivedAuthorizationChange: CLAuthorizationStatus?
    var receivedUpdatedLocations = [CLLocation]()
    var receivedError: Error?
    
    func locationManager(didChangeAuthorization status: CLAuthorizationStatus) {
        receivedAuthorizationChange = status
    }

    func locationManager(didUpdateLocations locations: [CLLocation]) {
        receivedUpdatedLocations.append(contentsOf: locations)
    }

    func locationManager(didFailWithError error: Error) {
        receivedError = error
    }
}
