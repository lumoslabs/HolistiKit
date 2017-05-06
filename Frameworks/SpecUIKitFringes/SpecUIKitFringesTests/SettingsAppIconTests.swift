import XCTest
@testable import SpecUIKitFringes

class SettingsAppIconTests: SpecSystemTestCase {

    func test_tappingOnTheSettingsAppIcon() {
        subject.tapSettingsAppIcon()
        XCTAssertEqual(subject.location, .settings)
        XCTAssertEqual(recorder.events, [])
    }

    func test_tappingOnTheSettingsAppIconWhenInTheApp() {
        subject.tapAppIcon()
        errorHandler.fatalErrorsOff {
            subject.tapSettingsAppIcon()
        }
        XCTAssertEqual(errorHandler.recordedError, .notOnSpringBoard)
    }
}
