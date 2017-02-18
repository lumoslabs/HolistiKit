import XCTest
@testable import SpecUIKitFringes

class AppIconTests: SpecSystemTestCase {

    func test_tappingOnTheAppIconWhenTheAppIsOff() {
        subject.tapAppIcon()
        XCTAssertEqual(appDelegate.events, [ .applicationDidLaunch, .applicationDidBecomeActive ])
    }

    func test_tappingOnTheAppIconWhenTheAppIsRunning() {
        subject.tapAppIcon()
        subject.tapHomeButton()
        appDelegate.clearEvents()
        subject.tapAppIcon()
        XCTAssertEqual(appDelegate.events, [ .applicationWillEnterForeground, .applicationDidBecomeActive ])
    }

    func test_tappingOnTheAppIconAfterTheAppHasBeenKilled() {
        subject.tapAppIcon()
        subject.doubleTapHomeButton()
        let oldAppDelegate = appDelegate!
        subject.swipeUpAppScreenshot()
        subject.tapHomeButton()
        subject.tapAppIcon()
        XCTAssertEqual(appDelegate.events, [ .applicationDidLaunch, .applicationDidBecomeActive ])
        XCTAssertNotSame(oldAppDelegate, appDelegate)
    }

    func test_tappingOnTheAppIconWhenInTheApp() {
        subject.tapAppIcon()
        fatalErrorsOff {
            self.subject.tapAppIcon()
        }
        XCTAssertEqual(errors, [ .notOnSpringBoard ])
    }

    func test_tappingOnTheAppIconWhenInTheAppSwitcher() {
        subject.doubleTapHomeButton()
        fatalErrorsOff {
            self.subject.tapAppIcon()
        }
        XCTAssertEqual(errors, [ .notOnSpringBoard ])
    }
}
