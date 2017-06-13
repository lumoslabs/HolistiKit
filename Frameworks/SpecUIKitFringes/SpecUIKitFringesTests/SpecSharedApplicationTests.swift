import XCTest
@testable import SpecUIKitFringes

class SpecSharedApplicationTests: XCTestCase {

    var subject: SpecSharedApplication!
    var system: SpecSystem!
    var recorder: Recorder!
    
    override func setUp() {
        super.setUp()
        recorder = Recorder()
        let errorHandler = SpecErrorHandler()
        let notificationCenter = SpecNotificationCenter(recorder: recorder)
        system = RecordingSpecSystem(recorder: recorder,
                                     errorHandler: errorHandler,
                                     notificationCenter: notificationCenter)
        subject = SpecSharedApplication(system: system)
    }

    func test_isNetworkActivityIndicatorVisibleStartsAsFalse() {
        XCTAssertFalse(subject.isNetworkActivityIndicatorVisible)
    }

    func test_openURLWithHTTPURL() {
        system.tapAppIcon()
        recorder.removeAllEvents()
        let url = URL(string: "https://www.google.com")!
        let returnValue = subject.openURL(url)
        XCTAssertTrue(returnValue)
        XCTAssertEqual(system.location, .otherApp)
        XCTAssertEqual(recorder.events, [.applicationWillResignActive,
                                         .notification(.UIApplicationWillResignActive),
                                         .applicationDidEnterBackground,
                                         .notification(.UIApplicationDidEnterBackground)])
        XCTAssertEqual(subject.openedURL, url)
    }

    func test_openURLWithSettingsURL() {
        system.tapAppIcon()
        recorder.removeAllEvents()
        let url = URL(string: UIApplicationOpenSettingsURLString)!
        let returnValue = subject.openURL(url)
        XCTAssertTrue(returnValue)
        XCTAssertEqual(system.location, .settingsApp)
        XCTAssertEqual(recorder.events, [.applicationWillResignActive,
                                         .notification(.UIApplicationWillResignActive),
                                         .applicationDidEnterBackground,
                                         .notification(.UIApplicationDidEnterBackground)])
        XCTAssertEqual(subject.openedURL, url)
    }
}
