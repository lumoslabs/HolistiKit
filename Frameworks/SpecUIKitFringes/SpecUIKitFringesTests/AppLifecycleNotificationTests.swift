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
        [.UIApplicationDidFinishLaunching, .UIApplicationDidBecomeActive].forEach(addNotification)
    }

    override func tearDown() {
        super.tearDown()
        tokens.forEach(notificationCenter.removeObserver)
    }

    func testUIApplicationDidFinishLaunchingNotification() {
        subject.tapAppIcon()
        XCTAssertEqual(recorder.events, [.applicationDidLaunch,
                                         .notification(.UIApplicationDidFinishLaunching),
                                         .applicationDidBecomeActive,
                                         .notification(.UIApplicationDidBecomeActive)])
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
