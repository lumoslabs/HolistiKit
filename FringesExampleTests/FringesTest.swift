import XCTest
@testable import FringesExample

class FringesTest: XCTestCase {

    // retain the window, as AppDelegate would
    private(set) var window: SpecWindow!
    
    override func setUp() {
        super.setUp()

        window = SpecWindow()
        let dashboardViewControllerFactory = SpecDashboardViewControllingFactory()
        let settingsViewControllerFactory = SpecSettingsViewControllerFactory()
        let appCoordinator = AppCoordinator(dashboardViewControllerFactory: dashboardViewControllerFactory,
                                            settingsViewControllerFactory: settingsViewControllerFactory)
        
        appCoordinator.didFinishLaunching(withWindow: window)
    }
}

extension FringesTest {

    var dashboard: SpecDashboardViewControllerUI! {
        return window.rootViewController as! SpecDashboardViewControllerUI
    }

    var settings: SpecSettingsViewControllerUI! {
        return dashboard.presentedViewController as! SpecSettingsViewControllerUI
    }
}
