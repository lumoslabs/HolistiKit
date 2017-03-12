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
}
