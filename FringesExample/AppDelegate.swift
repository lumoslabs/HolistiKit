import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let _window = UIWindow(frame: UIScreen.main.bounds)
        window = _window
        
        let dashboardNavigationControllerFactory = DashboardNavigationControllingFactory()
        let dashboardViewControllerFactory = DashboardViewControllingFactory()
        let settingsViewControllerFactory = SettingsViewControllerFactory()
        let appCoordinator = AppCoordinator(dashboardNavigationControllerFactory: dashboardNavigationControllerFactory,
                                            dashboardViewControllerFactory: dashboardViewControllerFactory,
                                            settingsViewControllerFactory: settingsViewControllerFactory)
        appCoordinator.didFinishLaunching(withWindow: _window)
        
        _window.makeKeyAndVisible()
        return true
    }
}
