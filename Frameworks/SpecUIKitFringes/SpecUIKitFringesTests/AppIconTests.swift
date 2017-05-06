import XCTest
@testable import SpecUIKitFringes

class AppIconTests: SpecSystemTestCase {

    func test_tappingOnTheAppIconWhenTheAppIsOff() {
        subject.tapAppIcon()
        XCTAssertEqual(recorder.events, [.applicationDidLaunch, .applicationDidBecomeActive])
    }

    func test_tappingOnTheAppIconWhenTheAppIsRunning() {
        subject.tapAppIcon()
        subject.tapHomeButton()
        recorder.removeAllEvents()
        subject.tapAppIcon()
        XCTAssertEqual(recorder.events, [.applicationWillEnterForeground, .applicationDidBecomeActive])
    }

    func test_tappingOnTheAppIconAfterTheAppHasBeenKilled() {
        subject.tapAppIcon()
        subject.doubleTapHomeButton()
        let oldAppDelegate = subject.appDelegate as! RecordingSpecApplicationDelegate
        subject.swipeUpAppScreenshot()
        recorder.removeAllEvents()
        subject.tapHomeButton()
        subject.tapAppIcon()
        XCTAssertEqual(recorder.events, [.applicationDidLaunch, .applicationDidBecomeActive])
        XCTAssertNotSame(oldAppDelegate, subject.appDelegate as! RecordingSpecApplicationDelegate)
    }

    func test_tappingOnTheAppIconWhenInTheApp() {
        subject.tapAppIcon()
        errorHandler.fatalErrorsOff {
            subject.tapAppIcon()
        }
        XCTAssertEqual(errorHandler.recordedError, .notOnSpringBoard)
    }

    func test_tappingOnTheAppIconWhenInTheAppSwitcher() {
        subject.doubleTapHomeButton()
        errorHandler.fatalErrorsOff {
            subject.tapAppIcon()
        }
        XCTAssertEqual(errorHandler.recordedError, .notOnSpringBoard)
    }
}
