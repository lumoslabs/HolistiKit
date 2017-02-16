import XCTest
import CoreLocation
@testable import SpecUIKitFringes

class GeneralAuthorizationStatusesTests: SpecLocationManagerTestCase {

    func test_WhenStatusNotDetermined() {
        XCTAssertEqual(subject.authorizationStatus(), .notDetermined)
        
        XCTAssertEqual(delegate.receivedAuthorizationChange, .notDetermined)
    }

    func test_WhenLocationServicesIsOff() {
        subject.setLocationServicesEnabledInSettingsApp(false)
        
        XCTAssertEqual(subject.authorizationStatus(), .denied)
    }
    
}
