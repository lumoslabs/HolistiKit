import XCTest
import CoreLocation
@testable import SpecUIKitFringes

class GeneralAuthorizationStatusesTests: SpecLocationManagerTestCase {

    func test_WhenStatusNotDetermined() {
        XCTAssertEqual(subject.authorizationStatus(), .notDetermined)
        
        XCTAssertNil(delegate.receivedAuthorizationChange)
    }

    func test_WhenLocationServicesIsTurnedOff() {
        subject.setLocationServicesEnabledInSettingsApp(false)
        
        XCTAssertEqual(subject.authorizationStatus(), .denied)
    }
    
}
