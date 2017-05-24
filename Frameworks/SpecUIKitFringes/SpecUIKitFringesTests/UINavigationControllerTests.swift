import XCTest
import SpecUIKitFringes

class UINavigationControllerTests: XCTestCase {

    var navigationController: RecordingUINavigationController!
    var recorder: Recorder!
    
    override func setUp() {
        super.setUp()
        recorder = Recorder()
        navigationController = RecordingUINavigationController(recorder: recorder, id: "nav")
    }

    func test_pushingAViewController() {
        let viewController = RecordingUIViewController(recorder: recorder)
        navigationController.pushViewController(viewController, animated: false)
        XCTAssertEqual(recorder.events, [.viewDidLoad(viewController),
                                         .viewWillAppear(viewController),
                                         .viewDidAppear(viewController)])
        XCTAssertEqual(viewController.navigationController, navigationController)
        XCTAssertEqual(navigationController.viewControllers, [viewController])
        XCTAssertEqual(navigationController.topViewController, viewController)
    }

    func test_pushingASecondViewController() {
        let first = RecordingUIViewController(recorder: recorder)
        navigationController.pushViewController(first, animated: false)
        recorder.removeAllEvents()
        
        let second = RecordingUIViewController(recorder: recorder)
        navigationController.pushViewController(second, animated: false)
        XCTAssertEqual(recorder.events, [.viewDidLoad(second),
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
        recorder.removeAllEvents()
        
        let second = RecordingUIViewController(recorder: recorder)
        navigationController.setViewControllers([second], animated: false)
        XCTAssertEqual(recorder.events, [.viewDidLoad(second),
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
        recorder.removeAllEvents()

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

    func test_accessingViewBeforePushingAViewController() {
        let viewController = RecordingUIViewController(recorder: recorder)
        _ = viewController.view
        navigationController.pushViewController(viewController, animated: false)
        XCTAssertEqual(recorder.events, [.viewDidLoad(viewController),
                                         .viewWillAppear(viewController),
                                         .viewDidAppear(viewController)])
    }

    func test_dismissingAViewController() {
        let topViewController = RecordingUIViewController(recorder: recorder, id: "top")
        navigationController.pushViewController(topViewController, animated: false)
        let presentedViewController = RecordingUIViewController(recorder: recorder, id: "presented")
        navigationController.present(presentedViewController, animated: false)
        recorder.removeAllEvents()
        navigationController.dismiss(animated: false) {
            self.recorder.record(.custom("completionCalled"))
        }
        XCTAssertEqual(recorder.events, [.viewWillDisappear(presentedViewController),
                                         .viewWillAppear(topViewController),
                                         .viewWillAppear(navigationController),
                                         .viewDidAppear(topViewController),
                                         .viewDidAppear(navigationController),
                                         .viewDidDisappear(presentedViewController),
                                         .custom("completionCalled")])
    }
}
