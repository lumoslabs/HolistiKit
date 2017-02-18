import XCTest
import CoreLocation
@testable import SpecUIKitFringes

class LocationServicesTests: SpecLocationManagerTestCase {

    func test_WhenStatusAuthorizedWhenInUse_ThenLocationServicesOff() {
        subject.setAuthorizationStatusInSettingsApp(.authorizedWhenInUse)
        
        subject.setLocationServicesEnabledInSettingsApp(false)
        
        XCTAssertEqual(delegate.receivedAuthorizationChange, .denied)
        XCTAssertEqual(subject.authorizationStatus(), .denied)
    }

    func test_RespondToTheLocationServicesDialogTwice() {
        subject.setLocationServicesEnabledInSettingsApp(false)
        subject.requestWhenInUseAuthorization()
        XCTAssertEqual(dialogManager.visibleDialog, .locationManager(.requestJumpToLocationServicesSettings))
        
        subject.tapSettingsOrCancelInDialog()
        
        XCTAssertNil(dialogManager.visibleDialog)
        
        subject.requestWhenInUseAuthorization()
        XCTAssertEqual(dialogManager.visibleDialog, .locationManager(.requestJumpToLocationServicesSettings))
        
        subject.tapSettingsOrCancelInDialog()
        
        XCTAssertNil(dialogManager.visibleDialog)
        
        subject.requestWhenInUseAuthorization()
        
        XCTAssertNil(dialogManager.visibleDialog)
    }

    func test_respondingToDialogWhenItIsNotPresented() {
        subject.fatalErrorsOff() {
            subject.tapSettingsOrCancelInDialog()
            XCTAssertEqual(subject.erroredWith, .noLocationServicesDialog)
        }
    }
    
}
