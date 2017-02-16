import XCTest
@testable import ExampleApp

class CLLocationManagerTests: FringesTest {

    func test_titleIsCorrect() {
        tapAppIcon()
        examplesUI.tapCLLocationManagerRow()
        XCTAssertEqual(clLocationManagerUI.title, "CLLocationManager")
    }

    func test_authorizationStatusStartsAtNotDetermined() {
        tapAppIcon()
        examplesUI.tapCLLocationManagerRow()
        XCTAssertEqual(clLocationManagerUI.authorizationStatus, "notDetermined")
    }

    func test_tappingOnRequestAuthorization() {
        tapAppIcon()
        examplesUI.tapCLLocationManagerRow()
        clLocationManagerUI.tapRequestAuthorizationRow()
        XCTAssertEqual(locationManager.dialog, .requestAccessWhileInUse)
    }

    func test_acceptingAnAuthorizationRequest() {
        tapAppIcon()
        examplesUI.tapCLLocationManagerRow()
        clLocationManagerUI.tapRequestAuthorizationRow()
        XCTAssertEqual(clLocationManagerUI.authorizationStatus, "notDetermined")
        locationManager.tapAllowInDialog()
        XCTAssertEqual(clLocationManagerUI.authorizationStatus, "authorizedWhenInUse")
    }
}
