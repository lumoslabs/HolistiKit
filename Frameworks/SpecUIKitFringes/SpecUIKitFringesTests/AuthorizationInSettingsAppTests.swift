import XCTest
import CoreLocation
import SpecUIKitFringes

class AuthorizationInSettingsAppTests: SpecLocationManagerTestCase {

    func test_WhenStatusNotDetermined_ThenAuthorizedWhenInUse() {
        subject.delegate = delegate
        XCTAssertEqual(subject.authorizationStatus(), .notDetermined)

        settingsApp.set(authorizationStatus: .authorizedWhenInUse)

        XCTAssertEqual(delegate.receivedAuthorizationChange, .authorizedWhenInUse)
        XCTAssertEqual(subject.authorizationStatus(), .authorizedWhenInUse)
    }

    func test_WhenStatusNotDetermined_ThenDenied() {
        subject.delegate = delegate
        XCTAssertEqual(subject.authorizationStatus(), .notDetermined)
        
        settingsApp.set(authorizationStatus: .denied)
        
        XCTAssertEqual(delegate.receivedAuthorizationChange, .denied)
        XCTAssertEqual(subject.authorizationStatus(), .denied)
    }
    
}
