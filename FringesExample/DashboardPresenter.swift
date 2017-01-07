import UIKit

class DashboardPresenter {

    private let viewControllerFactory: DashboardViewControllingFactory

    init(viewControllerFactory: DashboardViewControllingFactory) {
        self.viewControllerFactory = viewControllerFactory
    }

    func present(onWindow window: UIWindow) {
        let viewController = viewControllerFactory.createAndPresent(onWindow: window)
        viewController.set(backgroundColor: UIColor.green)
    }
}
