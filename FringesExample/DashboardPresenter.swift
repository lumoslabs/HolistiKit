import UIKit

class DashboardPresenter {

    private let viewControllerFactory: DashboardViewControllingFactoryProtocol
    private weak var viewController: DashboardViewControlling?

    init(viewControllerFactory: DashboardViewControllingFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
    }

    func present(onWindow window: UIWindow) {
        let _viewController = viewControllerFactory.create(withPresenter: self)
        viewController = _viewController
        _viewController.present(onWindow: window)
        _viewController.set(backgroundColor: UIColor.green)
    }
}
