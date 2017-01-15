import UIKit
@testable import FringesExample

protocol SpecNavigationControllerUI { }

class SpecNavigationController: SpecViewController, NavigationControlling, SpecNavigationControllerUI {

    fileprivate var viewControllers = [SpecViewController]()

    override var nextViewController: SpecViewController? {
        return viewControllers.last
    }

    override var topViewController: SpecViewController {
        return nextViewController!.topViewController
    }

    override func push(viewController: ViewControlling, animated: Bool) {
        guard let viewController = viewController as? SpecViewController else { fatalError() }
        viewControllers.append(viewController)
        viewController.set(navigationController: self)
        viewController.viewDidLoadAndAppear()
    }
}

extension NavigationControlling {

    var asSpecNavigationController: SpecNavigationController {
        return self as! SpecNavigationController
    }
}
