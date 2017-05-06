import XCTest
import SpecUIKitFringes

class HomeButtonTests: SpecSystemTestCase {

    func test_tappingOnTheHomeInTheSpringBoard() {
        subject.tapHomeButton()
        XCTAssertNil(subject.appDelegate)
    }

    func test_doubleTappingOnTheHomeButtonInTheSpringBoard() {
        subject.doubleTapHomeButton()
        XCTAssertNil(subject.appDelegate)
    }

    func test_tappingOnTheHomeButtonInTheApp() {
        subject.tapAppIcon()
        recorder.removeAllEvents()
        subject.tapHomeButton()
        XCTAssertEqual(recorder.events, [.applicationWillResignActive,
                                         .notification(.UIApplicationWillResignActive),
                                         .applicationDidEnterBackground,
                                         .notification(.UIApplicationDidEnterBackground)])
    }

    func test_doubleTappingOnTheHomeButtonInTheApp() {
        subject.tapAppIcon()
        recorder.removeAllEvents()
        subject.doubleTapHomeButton()
        XCTAssertEqual(recorder.events, [.applicationWillResignActive,
                                         .notification(.UIApplicationWillResignActive)])
    }
}
