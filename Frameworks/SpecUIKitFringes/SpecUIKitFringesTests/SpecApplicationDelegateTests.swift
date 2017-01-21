import XCTest
@testable import SpecUIKitFringes

class SpecApplicationDelegateTests: XCTestCase {

    var subject: RecordingSpecApplicationDelegate!
    
    override func setUp() {
        super.setUp()
        subject = RecordingSpecApplicationDelegate()
    }

    func test_tappingOnTheAppIcon() {
        subject.tapAppIcon()
        XCTAssertEqual(subject.events, [ .applicationDidLaunch ])
    }
}
