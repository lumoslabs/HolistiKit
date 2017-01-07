import XCTest
@testable import FringesExample

class FringesTest: XCTestCase {

    // retain AppCoordinator, as AppDelegate would
    var appCoordinator: AppCoordinator!

    var dashboard: SpecDashboardViewControllerUI!
    
    override func setUp() {
        super.setUp()

        let dashboardViewControllerFactory = SpecDashboardViewControllingFactory()
        let dashboardInteractor = DashboardInteractor()
        let dashboardPresenter = DashboardPresenter(viewControllerFactory: dashboardViewControllerFactory,
                                                    interactor: dashboardInteractor)
        let dashboardRouter = DashboardRouter(dashboardPresenter: dashboardPresenter)
        let router = RootRouter(dashboardRouter: dashboardRouter)
        let appCoordinator = AppCoordinator(router: router)
        let window = UIWindow()
        appCoordinator.didFinishLaunching(withWindow: window)
        dashboard = dashboardViewControllerFactory.viewController
    }
}
