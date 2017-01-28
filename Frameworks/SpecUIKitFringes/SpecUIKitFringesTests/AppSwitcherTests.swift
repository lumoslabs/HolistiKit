import XCTest
@testable import SpecUIKitFringes

class AppSwitcherTests: SpecSystemTestCase {

    func test_tappingOnTheHomeButtonComingFromTheSpringBoard() {
        subject.doubleTapHomeButton()
        subject.tapHomeButton()
        XCTAssertNil(appDelegate)
    }

    func test_tappingOnTheHomeButtonComingFromTheSpringBoardWhileTheAppIsRunning() {
        subject.tapAppIcon()
        subject.tapHomeButton()
        subject.doubleTapHomeButton()
        appDelegate.clearEvents()
        subject.tapHomeButton()
        XCTAssertEqual(appDelegate.events, [ ])
    }

    func test_tappingOnTheHomeButtonComingFromTheApp() {
        subject.tapAppIcon()
        subject.doubleTapHomeButton()
        appDelegate.clearEvents()
        subject.tapHomeButton()
        XCTAssertEqual(appDelegate.events, [ .applicationDidBecomeActive ])
    }

    func test_tappingOnTheAppScreenshot() {
        subject.tapAppIcon()
        subject.doubleTapHomeButton()
        appDelegate.clearEvents()
        subject.tapAppScreenshot()
        XCTAssertEqual(appDelegate.events, [ .applicationDidBecomeActive ])
    }

    func test_swipingUpOnTheAppScreenshotWhenTheAppIsRunning() {
        subject.tapAppIcon()
        subject.doubleTapHomeButton()
        appDelegate.clearEvents()
        let retainedAppDelegate = appDelegate
        subject.swipeUpAppScreenshot()
        XCTAssertEqual(retainedAppDelegate!.events, [ .applicationDidEnterBackground, .applicationWillTerminate ])
        XCTAssertNil(appDelegate)
    }

    func test_tappingOnTheAppScreenshotWhileOnTheSpringBoard() {
        fatalErrorsOff {
            self.subject.tapAppScreenshot()
        }
        XCTAssertEqual(recordedFatalErrors, [ .appSwitcherNotOpen, .noScreenshotInAppSwitcher ])
    }

    func test_tappingOnTheAppScreenshotWhileInTheApp() {
        subject.tapAppIcon()
        fatalErrorsOff {
            self.subject.tapAppScreenshot()
        }
        XCTAssertEqual(recordedFatalErrors, [ .appSwitcherNotOpen ])
    }

    func test_tappingOnTheAppScreenshotWhenTheAppHasNeverBeenRunBefore() {
        subject.doubleTapHomeButton()
        fatalErrorsOff {
            self.subject.tapAppScreenshot()
        }
        XCTAssertEqual(recordedFatalErrors, [ .noScreenshotInAppSwitcher ])
    }

    func test_tappingOnTheAppScreenshotWhenAlreadySwippedUp() {
        subject.tapAppIcon()
        subject.doubleTapHomeButton()
        subject.swipeUpAppScreenshot()
        fatalErrorsOff {
            self.subject.tapAppScreenshot()
        }
        XCTAssertEqual(recordedFatalErrors, [ .noScreenshotInAppSwitcher ])
    }
}
