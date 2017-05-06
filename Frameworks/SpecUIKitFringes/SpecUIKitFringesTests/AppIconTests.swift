import XCTest
@testable import SpecUIKitFringes

class AppIconTests: SpecSystemTestCase {

    func test_tappingOnTheAppIconWhenTheAppIsOff() {
        subject.tapAppIcon()
        XCTAssertEqual(recorder.events, [.applicationDidLaunch,
                                         .notification(.UIApplicationDidFinishLaunching),
                                         .applicationDidBecomeActive,
                                         .notification(.UIApplicationDidBecomeActive)])
    }

    func test_tappingOnTheAppIconWhenTheAppIsRunning() {
        subject.tapAppIcon()
        subject.tapHomeButton()
        recorder.removeAllEvents()
        subject.tapAppIcon()
        XCTAssertEqual(recorder.events, [.applicationWillEnterForeground,
                                         .notification(.UIApplicationWillEnterForeground),
                                         .applicationDidBecomeActive,
                                         .notification(.UIApplicationDidBecomeActive)])
    }

    func test_tappingOnTheAppIconAfterTheAppHasBeenKilled() {
        subject.tapAppIcon()
        subject.doubleTapHomeButton()
        let oldAppDelegate = subject.appDelegate as! RecordingSpecApplicationDelegate
        subject.swipeUpAppScreenshot()
        recorder.removeAllEvents()
        subject.tapHomeButton()
        subject.tapAppIcon()
        XCTAssertEqual(recorder.events, [.applicationDidLaunch,
                                         .notification(.UIApplicationDidFinishLaunching),
                                         .applicationDidBecomeActive,
                                         .notification(.UIApplicationDidBecomeActive)])
        XCTAssertNotSame(oldAppDelegate, subject.appDelegate as! RecordingSpecApplicationDelegate)
    }

    func test_tappingOnTheAppIconWhenInTheApp() {
        subject.tapAppIcon()
        errorHandler.fatalErrorsOff {
            subject.tapAppIcon()
        }
        XCTAssertEqual(errorHandler.recordedError, .expectedLocation(.springBoard))
    }

    func test_tappingOnTheAppIconWhenInTheAppSwitcher() {
        subject.doubleTapHomeButton()
        errorHandler.fatalErrorsOff {
            subject.tapAppIcon()
        }
        XCTAssertEqual(errorHandler.recordedError, .expectedLocation(.springBoard))
    }
}
