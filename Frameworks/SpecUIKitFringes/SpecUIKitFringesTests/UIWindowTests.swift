import XCTest
@testable import SpecUIKitFringes

class UIWindowTests: XCTestCase {

    var subject: UIWindow!
    var recorder: Recorder!
    
    override func setUp() {
        super.setUp()
        recorder = Recorder()
        subject = UIWindow()
    }

    func test_settingRootViewController() {
        let viewController = RecordingUIViewController(recorder: recorder)
        subject.rootViewController = viewController
        XCTAssertEqual(recorder.events, [.viewDidLoad(viewController),
                                         .viewWillAppear(viewController),
                                         .viewDidAppear(viewController)])
        XCTAssertEqual(subject.rootViewController, viewController)
    }

    func test_changingRootViewController() {
        let first = RecordingUIViewController(recorder: recorder)
        subject.rootViewController = first
        recorder.events.removeAll()

        let second = RecordingUIViewController(recorder: recorder)
        subject.rootViewController = second
        XCTAssertEqual(recorder.events, [.viewWillDisappear(first),
                                         .viewDidLoad(second),
                                         .viewWillAppear(second),
                                         .viewDidDisappear(first),
                                         .viewDidAppear(second)])
        XCTAssertEqual(subject.rootViewController, second)
    }
    
    func test_removingRootViewController() {
        let viewController = RecordingUIViewController(recorder: recorder)
        subject.rootViewController = viewController
        recorder.events.removeAll()
        
        subject.rootViewController = nil
        XCTAssertEqual(recorder.events, [.viewWillDisappear(viewController),
                                         .viewDidDisappear(viewController)])
        XCTAssertEqual(subject.rootViewController, nil)
    }
}
