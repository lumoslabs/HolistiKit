import UIKit
@testable import FringesExample

class SpecViewController: ViewControlling {
    
    weak var navigationController: SpecNavigationController?
    private var presentedViewController: SpecViewController?

    func viewDidLoad() { }
    func viewWillAppear() { }
    func viewDidAppear() { }
    func viewWillDisappear() { }
    func viewDidDisappear() { }

    func present(viewController: ViewControlling) {
        presentedViewController = viewController.asSpecViewController
        viewDisappear()
        presentedViewController!.viewLoadAndAppear()
    }

    func push(viewController: ViewControlling, animated: Bool) {
        navigationController!.push(viewController: viewController, animated: animated)
    }

    func set(navigationController: SpecNavigationController) {
        self.navigationController = navigationController
    }

    var topViewController: SpecViewController {
        return nextViewController?.topViewController ?? self
    }

    var nextViewController: SpecViewController? {
        return presentedViewController
    }

    var viewControllerStack: [SpecViewController] {
        return (nextViewController?.viewControllerStack ?? []) + [self]
    }

    func viewLoadAndAppear() {
        viewDidLoad()
        viewAppear()
    }
    
    func viewAppear() {
        viewWillAppear()
        viewDidAppear()
    }

    func viewDisappear() {
        viewWillDisappear()
        viewDidDisappear()
    }

    var asUIViewController: UIViewController {
        fatalError("This should never be called in tests")
    }
}

extension ViewControlling {

    var asSpecViewController: SpecViewController {
        return self as! SpecViewController
    }
}
