import UIKit
@testable import FringesExample

protocol SpecNavigationControllerUI {

    func tapBack()
}

class SpecNavigationController: SpecViewController, NavigationControlling {

    fileprivate var viewControllers = [SpecViewController]()

    override var nextViewController: SpecViewController? {
        return viewControllers.last
    }

    override var topViewController: SpecViewController {
        return nextViewController!.topViewController
    }

    override func push(viewController: ViewControlling, animated: Bool) {
        guard let viewController = viewController as? SpecViewController else { fatalError() }
        let previousTopViewController = viewControllers.last
        viewControllers.append(viewController)
        viewController.set(navigationController: self)
        if let previousTopViewController = previousTopViewController {
            previousTopViewController.viewDisappear()
        }
        viewController.viewLoadAndAppear()
    }
}

extension SpecNavigationController: SpecNavigationControllerUI {

    func tapBack() {
        if viewControllers.count < 2 {
            fatalError("There wouldn't be a back button since there aren't at least 2 view controllers in the stack.")
        }
        let poppedViewController = viewControllers.popLast()
        poppedViewController?.viewDisappear()
        viewControllers.last!.viewAppear()
    }
}
