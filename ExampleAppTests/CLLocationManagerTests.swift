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
}
