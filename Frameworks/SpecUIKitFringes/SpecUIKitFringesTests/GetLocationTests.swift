import XCTest
import CoreLocation
import SpecUIKitFringes

class GetLocationTests: SpecLocationManagerTestCase {

    func test_location_BeforeHavingEverReceivedALocation() {
        settingsApp.set(authorizationStatus: .authorizedWhenInUse)

        XCTAssertNil(subject.location)
    }

    func test_location_AfterHavingReceivedALocationBefore() {
        settingsApp.set(authorizationStatus: .authorizedWhenInUse)
        userLocation.coordinates = .berlin
        
        XCTAssertNotNil(subject.location)
    }

    func test_location_WhenNotAuthorized() {
        userLocation.coordinates = .berlin
        
        XCTAssertNil(subject.location)
    }
}
