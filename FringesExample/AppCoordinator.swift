import UIKit

class AppCoordinator {

    let router: RootRouter

    init(dashboardViewControllerFactory: DashboardViewControllingFactoryProtocol) {
        let dashboardInteractor = DashboardInteractor()
        let dashboardPresenter = DashboardPresenter(viewControllerFactory: dashboardViewControllerFactory,
                                                    interactor: dashboardInteractor)
        let dashboardRouter = DashboardRouter(dashboardPresenter: dashboardPresenter)
        self.router = RootRouter(dashboardRouter: dashboardRouter)
    }
    
    func didFinishLaunching(withWindow window: UIWindow) {
        router.present(onWindow: window)
    }
}
