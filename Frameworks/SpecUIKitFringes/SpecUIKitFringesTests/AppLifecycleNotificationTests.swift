import XCTest
import SpecUIKitFringes

class AppLifecycleNotificationTests: XCTestCase {

    var subject: SpecSystem!
    var recorder: Recorder!
    var notificationCenter: NotificationCenter!
    var tokens: [NSObjectProtocol]!
    
    override func setUp() {
        super.setUp()
        notificationCenter = NotificationCenter.default
        recorder = Recorder()
        subject = RecordingSpecSystem(recorder: recorder)

        tokens = [NSObjectProtocol]()
        [.UIApplicationDidEnterBackground,
         .UIApplicationWillEnterForeground,
         .UIApplicationWillResignActive,
         .UIApplicationWillTerminate,
         .UIApplicationDidFinishLaunching,
         .UIApplicationDidBecomeActive].forEach(addNotification)
    }

    override func tearDown() {
        super.tearDown()
        tokens.forEach(notificationCenter.removeObserver)
    }

    func testLaunchingApp() {
        subject.tapAppIcon()
        XCTAssertEqual(recorder.events, [.applicationDidLaunch,
                                         .notification(.UIApplicationDidFinishLaunching),
                                         .applicationDidBecomeActive,
                                         .notification(.UIApplicationDidBecomeActive)])
    }

    func testBackgrounding() {
        subject.tapAppIcon()
        recorder.removeAllEvents()
        subject.tapHomeButton()
        XCTAssertEqual(recorder.events, [.applicationWillResignActive,
                                         .notification(.UIApplicationWillResignActive),
                                         .applicationDidEnterBackground,
                                         .notification(.UIApplicationDidEnterBackground)])
    }

    func testForegrounding() {
        subject.tapAppIcon()
        subject.tapHomeButton()
        recorder.removeAllEvents()
        subject.tapAppIcon()
        XCTAssertEqual(recorder.events, [.applicationWillEnterForeground,
                                         .notification(.UIApplicationWillEnterForeground),
                                         .applicationDidBecomeActive,
                                         .notification(.UIApplicationDidBecomeActive)])
    }

    func testKillingApp() {
        subject.tapAppIcon()
        subject.doubleTapHomeButton()
        recorder.removeAllEvents()
        subject.swipeUpAppScreenshot()
        XCTAssertEqual(recorder.events, [.applicationDidEnterBackground,
                                         .notification(.UIApplicationDidEnterBackground),
                                         .applicationWillTerminate,
                                         .notification(.UIApplicationWillTerminate)])
    }

    private func addNotification(for notificationName: NSNotification.Name) {
        let token = notificationCenter.addObserver(
            forName: notificationName,
            object: nil,
            queue: nil) { [weak self] _ in
                self?.recorder.record(.notification(notificationName))
        }
        tokens.append(token)
    }
}
