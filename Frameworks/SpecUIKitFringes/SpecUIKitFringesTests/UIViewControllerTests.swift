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
        subject.present(presentedViewController, animated: false, completion: {
            self.recorder.record(.custom("completionCalled"))
        })
        XCTAssertEqual(recorder.events, [.viewDidLoad(presentedViewController),
                                         .viewWillDisappear(subject),
                                         .viewWillAppear(presentedViewController),
                                         .viewDidAppear(presentedViewController),
                                         .viewDidDisappear(subject),
                                         .custom("completionCalled")])
        XCTAssertEqual(subject.presentedViewController, presentedViewController)
        XCTAssertEqual(presentedViewController.presentingViewController, subject)
    }

    func test_dismissingFromThePresentingViewController() {
        let presentedViewController = RecordingUIViewController(recorder: recorder)
        subject.present(presentedViewController, animated: false, completion: nil)
        recorder.removeAllEvents()

        subject.dismiss(animated: false, completion: {
            self.recorder.record(.custom("completionCalled"))
        })
        XCTAssertEqual(recorder.events, [.viewWillDisappear(presentedViewController),
                                         .viewWillAppear(subject),
                                         .viewDidAppear(subject),
                                         .viewDidDisappear(presentedViewController),
                                         .custom("completionCalled")])
        XCTAssertNil(subject.presentedViewController)
        XCTAssertNil(presentedViewController.presentingViewController)
    }

    func test_dismissingFromThePresentedViewController() {
        let presentedViewController = RecordingUIViewController(recorder: recorder)
        subject.present(presentedViewController, animated: false, completion: nil)
        recorder.removeAllEvents()

        presentedViewController.dismiss(animated: false, completion: {
            self.recorder.record(.custom("completionCalled"))
        })
        XCTAssertEqual(recorder.events, [.viewWillDisappear(presentedViewController),
                                         .viewWillAppear(subject),
                                         .viewDidAppear(subject),
                                         .viewDidDisappear(presentedViewController),
                                         .custom("completionCalled")])
        XCTAssertNil(subject.presentedViewController)
        XCTAssertNil(presentedViewController.presentingViewController)
    }

    func test_dismissingFromAPresentedAndPresentingViewController() {
        let middlePresentedViewController = RecordingUIViewController(recorder: recorder)
        subject.present(middlePresentedViewController, animated: false, completion: nil)
        let topPresentedViewController = RecordingUIViewController(recorder: recorder)
        middlePresentedViewController.present(topPresentedViewController, animated: false, completion: nil)
        recorder.removeAllEvents()

        middlePresentedViewController.dismiss(animated: false, completion: {
            self.recorder.record(.custom("completionCalled"))
        })
        XCTAssertEqual(recorder.events, [.viewWillDisappear(topPresentedViewController),
                                         .viewWillAppear(middlePresentedViewController),
                                         .viewDidAppear(middlePresentedViewController),
                                         .viewDidDisappear(topPresentedViewController),
                                         .custom("completionCalled")])
        XCTAssertNil(middlePresentedViewController.presentedViewController)
        XCTAssertNil(topPresentedViewController.presentingViewController)
    }

    func test_dismissingWithNothingPresented() {
        subject.dismiss(animated: false, completion: nil)
        XCTAssertEqual(recorder.events, [])
        XCTAssertNil(subject.presentedViewController)
    }
}
