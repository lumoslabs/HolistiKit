import UIKit

class DashboardNavigationPresenter: PushablePresenter {

    private let viewControllerFactory: DashboardNavigationControllingFactoryProtocol
    private let router: DashboardRouter
    private weak var viewController: DashboardNavigationControlling?

    init(viewControllerFactory: DashboardNavigationControllingFactoryProtocol,
         router: DashboardRouter) {
        self.viewControllerFactory = viewControllerFactory
        self.router = router
    }

    func present(onWindow window: Windowing) {
        let _viewController = viewControllerFactory.create()
        viewController = _viewController
        router.pushDashboard(on: self)
        window.set(rootViewController: _viewController)
    }

    func push(viewController viewControllerToPush: ViewControlling) {
        viewController?.push(viewController: viewControllerToPush, animated: false)
    }
}
