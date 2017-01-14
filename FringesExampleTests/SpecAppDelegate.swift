@testable import FringesExample

class SpecAppDelegate {
    
    private(set) var window: SpecWindow!

    func applicationDidLaunch() {
        window = SpecWindow()
        
        let dashboardNavigationControllerFactory = SpecDashboardNavigationControllingFactory()
        let dashboardViewControllerFactory = SpecDashboardViewControllingFactory()
        let settingsViewControllerFactory = SpecSettingsViewControllerFactory()
        let appCoordinator = AppCoordinator(dashboardNavigationControllerFactory: dashboardNavigationControllerFactory,
                                            dashboardViewControllerFactory: dashboardViewControllerFactory,
                                            settingsViewControllerFactory: settingsViewControllerFactory)
        
        appCoordinator.didFinishLaunching(withWindow: window)
    }
}
