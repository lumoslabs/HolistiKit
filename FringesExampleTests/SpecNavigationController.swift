import UIKit
@testable import FringesExample

protocol SpecNavigationControllerUI {
    
    var topViewController: ViewControlling? { get }
}

class SpecNavigationController: SpecViewController, NavigationControlling, SpecNavigationControllerUI {

    private var viewControllers = [ViewControlling]()

    var topViewController: ViewControlling? {
        return viewControllers.last
    }

    override func push(viewController: ViewControlling, animated: Bool) {
        guard let viewController = viewController as? SpecViewController else { fatalError() }
        viewControllers.append(viewController)
        viewController.navigationControlling = self
        viewController.viewDidLoadAndAppear()
    }
}
