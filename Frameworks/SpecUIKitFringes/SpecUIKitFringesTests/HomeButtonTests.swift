import XCTest
@testable import SpecUIKitFringes

class HomeButtonTests: SpecSystemTestCase {

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
}
