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
        XCTAssertEqual(navigationController.viewControllers, [viewController])
        XCTAssertEqual(navigationController.topViewController, viewController)
    }

    func test_pushingASecondViewController() {
        let first = RecordingUIViewController(recorder: recorder)
        navigationController.pushViewController(first, animated: false)
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

    func test_settingViewControllersWhenThereIsAlreadyAViewController() {
        let first = RecordingUIViewController(recorder: recorder)
        navigationController.pushViewController(first, animated: false)
        recorder.events.removeAll()
        
        let second = RecordingUIViewController(recorder: recorder)
        navigationController.setViewControllers([second], animated: false)
        XCTAssertEqual(recorder.events, [.setViewControllers(navigationController, [second]),
                                         .viewDidLoad(second),
                                         .viewWillDisappear(first),
                                         .viewWillAppear(second),
                                         .viewDidDisappear(first),
                                         .viewDidAppear(second)])
        XCTAssertEqual(navigationController.viewControllers, [second])
        XCTAssertEqual(navigationController.topViewController, second)
        XCTAssertNil(first.navigationController)
        XCTAssertEqual(second.navigationController, navigationController)
    }

    func test_popViewControllerWhenThereAreMoreThanOneViewControllers() {
        let first = RecordingUIViewController(recorder: recorder)
        let second = RecordingUIViewController(recorder: recorder)
        navigationController.setViewControllers([first, second], animated: false)
        recorder.events.removeAll()

        let poppedViewController = navigationController.popViewController(animated: false)
        XCTAssertEqual(recorder.events, [.viewWillDisappear(second),
                                         .viewWillAppear(first),
                                         .viewDidDisappear(second),
                                         .viewDidAppear(first)])
        XCTAssertEqual(poppedViewController, second)
        XCTAssertEqual(navigationController.viewControllers, [first])
        XCTAssertEqual(navigationController.topViewController, first)
        XCTAssertNil(second.navigationController)
        XCTAssertEqual(first.navigationController, navigationController)
    }
}
