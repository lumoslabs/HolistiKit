import XCTest
import CoreLocation
import SpecUIKitFringes

class UserMovementTests: SpecLocationManagerTestCase {

    func test_initialLocation() {
        settingsApp.set(authorizationStatus: .authorizedWhenInUse)

        XCTAssertNil(subject.location?.coordinate)
    }

    func test_settingCoordinates() {
        settingsApp.set(authorizationStatus: .authorizedWhenInUse)

        userLocation.coordinates = .berlin

        XCTAssertEqual(subject.location?.coordinate, .berlin)
    }
}
