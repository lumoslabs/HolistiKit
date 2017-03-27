import XCTest
@testable import SpecUIKitFringes

class UIAlertControllerTests: XCTestCase {

    var subject: RecordingUIAlertController!
    var recorder: Recorder!
    
    override func setUp() {
        super.setUp()
        recorder = Recorder()
        subject = RecordingUIAlertController(recorder: recorder)
    }

    func test_presentingAnAlertController() {
        let presentingViewController = RecordingUIViewController(recorder: recorder)
        presentingViewController.present(subject, animated: false, completion: {
            self.recorder.record(.custom("completionCalled"))
        })
        XCTAssertEqual(recorder.events, [.viewDidLoad(subject),
                                         .viewWillAppear(subject),
                                         .viewDidAppear(subject),
                                         .custom("completionCalled")])
        XCTAssertEqual(presentingViewController.presentedViewController, subject)
        XCTAssertEqual(subject.presentingViewController, presentingViewController)
    }

    func test_dismissingAnAlertController() {
        let presentingViewController = RecordingUIViewController(recorder: recorder)
        presentingViewController.present(subject, animated: false, completion: nil)
        recorder.removeAllEvents()

        presentingViewController.dismiss(animated: false, completion: {
            self.recorder.record(.custom("completionCalled"))
        })
        XCTAssertEqual(recorder.events, [.viewWillDisappear(subject),
                                         .viewDidDisappear(subject),
                                         .custom("completionCalled")])
        XCTAssertNil(presentingViewController.presentedViewController)
        XCTAssertNil(subject.presentingViewController)
    }
}
