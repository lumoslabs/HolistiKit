import XCTest
import CoreLocation
@testable import SpecUIKitFringes

class LocationServicesTests: SpecLocationManagerTestCase {

    func test_WhenStatusAuthorizedWhenInUse_ThenLocationServicesOff() {
        subject.delegate = delegate
        settingsApp.set(authorizationStatus: .authorizedWhenInUse)
        
        settingsApp.set(locationServicesEnabled: false)
        
        XCTAssertEqual(delegate.receivedAuthorizationChange, .denied)
        XCTAssertEqual(subject.authorizationStatus(), .denied)
    }

    func test_RespondToTheLocationServicesDialogTwice() {
        settingsApp.set(locationServicesEnabled: false)
        subject.requestWhenInUseAuthorization()
        XCTAssertEqual(dialogManager.visibleDialog, .locationManager(.requestJumpToLocationServicesSettings))
        
        dialogManager.tap(.settings)
        
        XCTAssertNil(dialogManager.visibleDialog)
        
        subject.requestWhenInUseAuthorization()
        XCTAssertEqual(dialogManager.visibleDialog, .locationManager(.requestJumpToLocationServicesSettings))
        
        dialogManager.tap(.cancel)
        
        XCTAssertNil(dialogManager.visibleDialog)
        
        subject.requestWhenInUseAuthorization()
        
        XCTAssertNil(dialogManager.visibleDialog)
    }

    func test_respondingToDialogWhenItIsNotPresented() {
        errorHandler.fatalErrorsOff {
            dialogManager.tap(.cancel)
        }
        XCTAssertEqual(errorHandler.recordedError, .noDialog)
    }
    
}
