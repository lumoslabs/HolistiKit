import XCTest
import CoreLocation
import SpecUIKitFringes

class UserMovementTests: SpecLocationManagerTestCase {

    func test_userIsInBerlin() {
        settingsApp.set(authorizationStatus: .authorizedWhenInUse)

        userLocation.userIsInBerlin()

        let berlin = CLLocationCoordinate2D(latitude: 52.52, longitude: 13.405)
        XCTAssertEqual(subject.location?.coordinate, berlin)
    }
}
