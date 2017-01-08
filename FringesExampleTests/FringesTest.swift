import XCTest
@testable import FringesExample

class FringesTest: XCTestCase {

    // retain AppCoordinator, as AppDelegate would
    var appCoordinator: AppCoordinator!

    var dashboard: SpecDashboardViewControllerUI!
    
    override func setUp() {
        super.setUp()

        let dashboardViewControllerFactory = SpecDashboardViewControllingFactory()
        let settingsViewControllerFactory = SpecSettingsViewControllerFactory()
        let appCoordinator = AppCoordinator(dashboardViewControllerFactory: dashboardViewControllerFactory,
                                            settingsViewControllerFactory: settingsViewControllerFactory)
        let window = SpecWindow()
        appCoordinator.didFinishLaunching(withWindow: window)
        dashboard = dashboardViewControllerFactory.viewController
    }
}
