import XCTest
@testable import SpecUIKitFringes

class SpecSharedApplicationTests: XCTestCase {

    var subject: SpecSharedApplication!
    var system: SpecSystem!
    var recorder: Recorder!
    
    override func setUp() {
        super.setUp()
        recorder = Recorder()
        system = RecordingSpecSystem(recorder: recorder)
        subject = SpecSharedApplication(system: system)
    }

    func test_isNetworkActivityIndicatorVisibleStartsAsFalse() {
        XCTAssertFalse(subject.isNetworkActivityIndicatorVisible)
    }

    func test_openURLWithSettingsURL() {
        system.tapAppIcon()
        let url = URL(string: UIApplicationOpenSettingsURLString)!
        let returnValue = subject.openURL(url)
        XCTAssertTrue(returnValue)
        XCTAssertEqual(system.location, .settings)
    }
}
