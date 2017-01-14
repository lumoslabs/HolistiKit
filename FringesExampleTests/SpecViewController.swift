import UIKit
@testable import FringesExample

protocol SpecViewControllerUI {
    
    var presentedViewController: ViewControlling? { get }
}

class SpecViewController: ViewControlling, SpecViewControllerUI {
    
    private(set) var presentedViewController: ViewControlling?
    var navigationControlling: NavigationControlling?

    func viewDidLoad() { }

    func present(onWindow window: Windowing) {
        let specWindow = window as! SpecWindow
        specWindow.rootViewController = self
    }

    func present(viewController: ViewControlling) {
        presentedViewController = viewController
        viewController.viewDidLoad()
    }

    func push(viewController: ViewControlling, animated: Bool) {
        navigationControlling?.push(viewController: viewController, animated: animated)
    }

    var asUIViewController: UIViewController {
        fatalError("This should never be called in tests")
    }
}
