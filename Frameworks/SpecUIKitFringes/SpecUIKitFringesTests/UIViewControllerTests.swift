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

    func test_dismissingAViewController() {
        let presentedViewController = RecordingUIViewController(recorder: recorder)
        subject.present(presentedViewController, animated: false, completion: nil)
        recorder.events.removeAll()

        subject.dismiss(animated: false, completion: nil)
        XCTAssertEqual(recorder.events, [.viewWillDisappear(presentedViewController),
                                         .viewWillAppear(subject),
                                         .viewDidAppear(subject),
                                         .viewDidDisappear(presentedViewController)])
        XCTAssertNil(subject.presentedViewController)
        XCTAssertNil(presentedViewController.presentingViewController)
    }
}
