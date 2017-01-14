import UIKit
@testable import FringesExample

class SpecViewController: ViewControlling {
    
    var navigationControlling: SpecNavigationController?
    private(set) var presentedViewController: SpecViewController?

    func viewDidLoad() { }

    func present(viewController: ViewControlling) {
        presentedViewController = viewController.asSpecViewController
        presentedViewController!.viewDidLoadAndAppear()
    }

    func push(viewController: ViewControlling, animated: Bool) {
        navigationControlling!.push(viewController: viewController, animated: animated)
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
