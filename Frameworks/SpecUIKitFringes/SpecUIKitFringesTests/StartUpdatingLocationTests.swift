import XCTest
import CoreLocation
import SpecUIKitFringes

class StartUpdatingLocationTests: SpecLocationManagerTestCase {

    func test_startUpdatingLocation() {
        subject.delegate = delegate
        settingsApp.set(authorizationStatus: .authorizedWhenInUse)
        subject.startUpdatingLocation()
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 0)
        
        userLocation.userIsInBerlin()
        
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 1)
        
        userLocation.userIsInBerlin()
        
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 2)
    }

    func test_startUpdatingLocation_WhileNotDetermined() {
        XCTAssertEqual(subject.authorizationStatus(), .notDetermined)
        XCTAssertNil(delegate.receivedError)

        subject.startUpdatingLocation()

        XCTAssertNil(delegate.receivedError)
    }

    func test_receivingLocation_WithoutWantingLocation() {
        settingsApp.set(authorizationStatus: .authorizedWhenInUse)
        userLocation.userIsInBerlin()
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 0)
    }
}
