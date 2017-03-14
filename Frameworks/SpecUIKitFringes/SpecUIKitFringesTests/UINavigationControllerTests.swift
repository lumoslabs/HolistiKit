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

    func test_pushingAViewController() {
        let viewController = RecordingUIViewController(recorder: recorder)
        navigationController.pushViewController(viewController, animated: false)
        XCTAssertEqual(viewController.navigationController, navigationController)
        XCTAssertEqual(navigationController.topViewController, viewController)
    }

    func test_pushingASecondViewController() {
        let first = RecordingUIViewController(recorder: recorder)
        navigationController.push(viewController: first, animated: false)
        recorder.events.removeAll()
        
        let second = RecordingUIViewController(recorder: recorder)
        navigationController.pushViewController(second, animated: false)
        XCTAssertEqual(recorder.events, [.pushViewController(navigationController, second),
                                         .viewDidLoad(second),
                                         .viewWillDisappear(first),
                                         .viewWillAppear(second),
                                         .viewDidDisappear(first),
                                         .viewDidAppear(second)])
        XCTAssertEqual(navigationController.viewControllers, [first, second])
        XCTAssertEqual(navigationController.topViewController, second)
        XCTAssertEqual(first.navigationController, navigationController)
        XCTAssertEqual(second.navigationController, navigationController)
    }
}
