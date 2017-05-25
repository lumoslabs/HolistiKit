import XCTest
import CoreLocation
import SpecUIKitFringes

class GetLocationTests: SpecLocationManagerTestCase {

    func test_location_BeforeHavingEverReceivedALocation() {
        XCTAssertNil(subject.location)
    }

    func test_location_AfterHavingReceivedALocationBefore() {
        subject.delegate = delegate
        settingsApp.set(authorizationStatus: .authorizedWhenInUse)
        subject.requestLocation()
        userLocation.coordinates = .berlin
        
        XCTAssertNotNil(subject.location)
    }
}
