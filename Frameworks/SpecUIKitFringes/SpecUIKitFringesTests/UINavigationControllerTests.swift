import XCTest
@testable import SpecUIKitFringes

class UINavigationControllerTests: XCTestCase {

    var navigationController: RecordingUINavigationController!
    var recorder: Recorder!
    
    override func setUp() {
        super.setUp()
        recorder = Recorder()
        navigationController = RecordingUINavigationController(recorder: recorder)
    }

    func test_pushingASecondViewController() {
        let first = RecordingUIViewController(recorder: recorder)
        navigationController.push(viewController: first, animated: false)
        recorder.events.removeAll()
        
        let second = RecordingUIViewController(recorder: recorder)
        navigationController.push(viewController: second, animated: false)
        XCTAssertEqual(recorder.events, [.pushViewController(navigationController, second),
                                         .viewDidLoad(second),
                                         .viewWillDisappear(first),
                                         .viewWillAppear(second),
                                         .viewDidDisappear(first),
                                         .viewDidAppear(second)])
        XCTAssertEqual(navigationController.viewControllers, [first, second])
    }
}
