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
        XCTAssertEqual(systemDialog.visibleDialog, .locationManager(.requestJumpToLocationServicesSettings))
        
        subject.tapSettingsOrCancelInDialog()
        
        XCTAssertNil(systemDialog.visibleDialog)
        
        subject.requestWhenInUseAuthorization()
        XCTAssertEqual(systemDialog.visibleDialog, .locationManager(.requestJumpToLocationServicesSettings))
        
        subject.tapSettingsOrCancelInDialog()
        
        XCTAssertNil(systemDialog.visibleDialog)
        
        subject.requestWhenInUseAuthorization()
        
        XCTAssertNil(systemDialog.visibleDialog)
    }

    func test_respondingToDialogWhenItIsNotPresented() {
        subject.fatalErrorsOff() {
            subject.tapSettingsOrCancelInDialog()
            XCTAssertEqual(subject.erroredWith, .noLocationServicesDialog)
        }
    }
    
}
