import XCTest
@testable import SpecUIKitFringes

class AppSwitcherTests: SpecSystemTestCase {

    func test_tappingOnTheHomeButtonComingFromTheSpringBoard() {
        subject.doubleTapHomeButton()
        subject.tapHomeButton()
        XCTAssertNil(subject.appDelegate)
    }

    func test_doubleTappingOnTheHomeButtonComingFromTheSpringBoard() {
        subject.doubleTapHomeButton()
        subject.doubleTapHomeButton()
        XCTAssertNil(subject.appDelegate)
    }

    func test_tappingOnTheHomeButtonComingFromTheSpringBoardWhileTheAppIsRunning() {
        subject.tapAppIcon()
        subject.tapHomeButton()
        subject.doubleTapHomeButton()
        recorder.removeAllEvents()
        subject.tapHomeButton()
        XCTAssertEqual(recorder.events, [])
    }

    func test_doubldTappingOnTheHomeButtonComingFromTheSpringBoardWhileTheAppIsRunning() {
        subject.tapAppIcon()
        subject.tapHomeButton()
        subject.doubleTapHomeButton()
        recorder.removeAllEvents()
        subject.doubleTapHomeButton()
        XCTAssertEqual(recorder.events, [])
    }

    func test_tappingOnTheHomeButtonComingFromTheApp() {
        subject.tapAppIcon()
        subject.doubleTapHomeButton()
        recorder.removeAllEvents()
        subject.tapHomeButton()
        XCTAssertEqual(recorder.events, [.applicationDidBecomeActive])
    }

    func test_tappingOnTheAppScreenshot() {
        subject.tapAppIcon()
        subject.doubleTapHomeButton()
        recorder.removeAllEvents()
        subject.tapAppScreenshot()
        XCTAssertEqual(recorder.events, [.applicationDidBecomeActive])
    }

    func test_swipingUpOnTheAppScreenshotWhenTheAppIsRunning() {
        subject.tapAppIcon()
        subject.doubleTapHomeButton()
        recorder.removeAllEvents()
        subject.swipeUpAppScreenshot()
        XCTAssertEqual(recorder.events, [.applicationDidEnterBackground, .applicationWillTerminate])
        XCTAssertNil(subject.appDelegate)
    }

    func test_tappingOnTheAppScreenshotWhileOnTheSpringBoard() {
        errorHandler.fatalErrorsOff {
            self.subject.tapAppScreenshot()
        }
        XCTAssertEqual(errorHandler.recordedError, .appSwitcherNotOpen)
    }

    func test_tappingOnTheAppScreenshotWhileInTheApp() {
        subject.tapAppIcon()
        errorHandler.fatalErrorsOff {
            self.subject.tapAppScreenshot()
        }
        XCTAssertEqual(errorHandler.recordedError, .appSwitcherNotOpen)
    }

    func test_tappingOnTheAppScreenshotWhenTheAppHasNeverBeenRunBefore() {
        subject.doubleTapHomeButton()
        errorHandler.fatalErrorsOff {
            self.subject.tapAppScreenshot()
        }
        XCTAssertEqual(errorHandler.recordedError, .noScreenshotInAppSwitcher)
    }

    func test_tappingOnTheAppScreenshotWhenAlreadySwippedUp() {
        subject.tapAppIcon()
        subject.doubleTapHomeButton()
        subject.swipeUpAppScreenshot()
        errorHandler.fatalErrorsOff {
            self.subject.tapAppScreenshot()
        }
        XCTAssertEqual(errorHandler.recordedError, .noScreenshotInAppSwitcher)
    }
}
