import XCTest
@testable import SpecUIKitFringes

class AppSwitcherTests: SpecSystemTestCase {

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

    func test_tappingOnTheAppScreenshotWhileNotInTheAppSwitcher() {
        fatalErrorsOff {
            self.subject.tapAppScreenshot()
        }
        XCTAssertEqual(recordedFatalErrors, [ .appSwitcherNotOpen, .noScreenshotInAppSwitcher ])
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
