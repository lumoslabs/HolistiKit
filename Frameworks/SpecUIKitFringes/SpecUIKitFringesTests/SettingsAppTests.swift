import XCTest
@testable import SpecUIKitFringes

class SettingsAppTests: SpecSystemTestCase {

    func test_tappingOnTheSettingsAppIcon() {
        subject.tapSettingsAppIcon()
        XCTAssertEqual(subject.location, .settingsApp)
        XCTAssertEqual(recorder.events, [])
    }

    func test_tappingOnTheSettingsAppIconWhenInTheApp() {
        subject.tapAppIcon()
        errorHandler.fatalErrorsOff {
            subject.tapSettingsAppIcon()
        }
        XCTAssertEqual(errorHandler.recordedError, .expectedLocation(.springBoard))
    }

    func test_accessingTheSettingsApp() {
        subject.tapSettingsAppIcon()
        _ = subject.settingsApp
    }

    func test_accessingTheSettingsAppWhenNotInTheSettingsApp() {
        errorHandler.fatalErrorsOff {
            _ = subject.settingsApp
        }
        XCTAssertEqual(errorHandler.recordedError, .expectedLocation(.settingsApp))
    }
}
