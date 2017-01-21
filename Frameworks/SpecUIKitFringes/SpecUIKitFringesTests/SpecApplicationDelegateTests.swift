import XCTest
@testable import SpecUIKitFringes

class SpecApplicationDelegateTests: XCTestCase {

    var subject: RecordingSpecApplicationDelegate!
    
    override func setUp() {
        super.setUp()
        subject = RecordingSpecApplicationDelegate()
    }

    func test_tappingOnTheAppIconWhenTheAppIsOff() {
        subject.tapAppIcon()
        XCTAssertEqual(subject.events, [ .applicationDidLaunch, .applicationDidBecomeActive ])
    }

    func test_tappingOnTheAppIconWhenTheAppIsRunning() {
        subject.tapAppIcon()
        subject.tapHomeButton()
        subject.clearEvents()
        subject.tapAppIcon()
        XCTAssertEqual(subject.events, [ .applicationWillEnterForeground, .applicationDidBecomeActive ])
    }

    func test_tappingOnTheHomeButton() {
        subject.tapAppIcon()
        subject.clearEvents()
        subject.tapHomeButton()
        XCTAssertEqual(subject.events, [ .applicationWillResignActive, .applicationDidEnterBackground ])
    }
}
