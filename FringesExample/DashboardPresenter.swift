import UIKit

class DashboardPresenter {

    private let viewControllerFactory: DashboardViewControllingFactoryProtocol

    init(viewControllerFactory: DashboardViewControllingFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
    }

    func present(onWindow window: UIWindow) {
        let viewController = viewControllerFactory.createAndPresent(onWindow: window)
        viewController.set(backgroundColor: UIColor.green)
    }
}
