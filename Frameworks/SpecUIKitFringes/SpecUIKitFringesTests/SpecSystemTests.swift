import XCTest
@testable import SpecUIKitFringes

class SpecSystemTests: XCTestCase {

    var subject: SpecSystem!
    
    override func setUp() {
        super.setUp()
        subject = RecordingSpecSystem()
    }

    private var appDelegate: RecordingSpecApplicationDelegate! {
        return subject.appDelegate as? RecordingSpecApplicationDelegate
    }

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

    func test_tappingOnTheHomeButton() {
        subject.tapAppIcon()
        appDelegate.clearEvents()
        subject.tapHomeButton()
        XCTAssertEqual(appDelegate.events, [ .applicationWillResignActive, .applicationDidEnterBackground ])
    }

    func test_doubleTappingOnTheHomeButton() {
        subject.tapAppIcon()
        appDelegate.clearEvents()
        subject.doubleTapHomeButton()
        XCTAssertEqual(appDelegate.events, [ .applicationWillResignActive ])
    }

    func test_tappingOnTheHomeButtonWhileInAppSwitcher() {
        subject.tapAppIcon()
        subject.doubleTapHomeButton()
        appDelegate.clearEvents()
        subject.tapHomeButton()
        XCTAssertEqual(appDelegate.events, [ .applicationDidBecomeActive ])
    }

    func test_tappingOnTheAppScreenshotWhileInAppSwitcher() {
        subject.tapAppIcon()
        subject.doubleTapHomeButton()
        appDelegate.clearEvents()
        subject.tapAppScreenshot()
        XCTAssertEqual(appDelegate.events, [ .applicationDidBecomeActive ])
    }

    func test_swipingUpOnTheAppScreenshotWhileInTheAppSwitcher() {
        subject.tapAppIcon()
        subject.doubleTapHomeButton()
        appDelegate.clearEvents()
        let retainedAppDelegate = appDelegate
        subject.swipeUpAppScreenshot()
        XCTAssertEqual(retainedAppDelegate!.events, [ .applicationDidEnterBackground, .applicationWillTerminate ])
        XCTAssertNil(appDelegate)
    }

    func test_tappingOnTheAppIconAfterTheAppHasBeenKilled() {
        subject.tapAppIcon()
        subject.doubleTapHomeButton()
        let oldAppDelegate = appDelegate!
        subject.swipeUpAppScreenshot()
        subject.tapAppIcon()
        XCTAssertEqual(appDelegate.events, [ .applicationDidLaunch, .applicationDidBecomeActive ])
        XCTAssertNotSame(oldAppDelegate, appDelegate)
    }
}

private class RecordingSpecSystem: SpecSystem {

    override func createAppDelegateBundle() -> SpecSystem.AppDelegateBundle {
        return SpecSystem.AppDelegateBundle(appDelegate: RecordingSpecApplicationDelegate(),
                                            temporarilyStrong: [])
    }
}
