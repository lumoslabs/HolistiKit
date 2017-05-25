import XCTest
import CoreLocation
import SpecUIKitFringes

class RequestLocationTests: SpecLocationManagerTestCase {

    func test_requestLocation() {
        subject.delegate = delegate
        settingsApp.set(authorizationStatus: .authorizedWhenInUse)
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 0)

        subject.requestLocation()
        userLocation.userIsInBerlin()

        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 1)
    }

    func test_requestLocation_WhileNotDetermined() {
        subject.delegate = delegate
        XCTAssertEqual(subject.authorizationStatus(), .notDetermined)
        XCTAssertNil(delegate.receivedError)

        subject.requestLocation()

        XCTAssertNotNil(delegate.receivedError)
    }
}
