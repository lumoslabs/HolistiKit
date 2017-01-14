import UIKit
@testable import FringesExample

class SpecViewController: ViewControlling {
    
    private var navigationController: SpecNavigationController?
    private var presentedViewController: SpecViewController?

    func viewDidLoad() { }

    func present(viewController: ViewControlling) {
        presentedViewController = viewController.asSpecViewController
        presentedViewController!.viewDidLoadAndAppear()
    }

    func push(viewController: ViewControlling, animated: Bool) {
        navigationController!.push(viewController: viewController, animated: animated)
    }

    func set(navigationController: SpecNavigationController) {
        self.navigationController = navigationController
    }

    var asUIViewController: UIViewController {
        fatalError("This should never be called in tests")
    }

    var topViewController: SpecViewController {
        if let presentedViewController = presentedViewController {
            return presentedViewController.topViewController
        }
        return self
    }

    func viewDidLoadAndAppear() {
        viewDidLoad()
    }
}

extension ViewControlling {

    var asSpecViewController: SpecViewController {
        return self as! SpecViewController
    }
}
