import XCTest
@testable import FringesExample

class FringesTest: XCTestCase {

    // retain AppCoordinator, as AppDelegate would
    var appCoordinator: AppCoordinator!

    var dashboard: SpecDashboardViewControllerUI!
    
    override func setUp() {
        super.setUp()

        let dashboardViewControllerFactory = SpecDashboardViewControllingFactory()
        let appCoordinator = AppCoordinator(dashboardViewControllerFactory: dashboardViewControllerFactory)
        let window = UIWindow()
        appCoordinator.didFinishLaunching(withWindow: window)
        dashboard = dashboardViewControllerFactory.viewController
    }
}
