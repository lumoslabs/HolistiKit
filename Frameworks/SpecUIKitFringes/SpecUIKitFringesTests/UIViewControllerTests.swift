import XCTest
@testable import SpecUIKitFringes

class UIViewControllerTests: XCTestCase {

    var subject: RecordingUIViewController!
    var recorder: Recorder!
    
    override func setUp() {
        super.setUp()
        recorder = Recorder()
        subject = RecordingUIViewController(recorder: recorder)
    }

    func test_presentingAViewController() {
        let presentedViewController = RecordingUIViewController(recorder: recorder)
        subject.present(presentedViewController, animated: false, completion: nil)
        XCTAssertEqual(recorder.events, [.viewDidLoad(presentedViewController),
                                         .viewWillDisappear(subject),
                                         .viewWillAppear(presentedViewController),
                                         .viewDidAppear(presentedViewController),
                                         .viewDidDisappear(subject)])
        XCTAssertEqual(subject.presentedViewController, presentedViewController)
        XCTAssertEqual(presentedViewController.presentingViewController, subject)
    }
}
