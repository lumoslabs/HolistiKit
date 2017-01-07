import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let _window = UIWindow(frame: UIScreen.main.bounds)
        window = _window

        let dashboardViewControllerFactory = DashboardViewControllingFactory()
        let appCoordinator = AppCoordinator(dashboardViewControllerFactory: dashboardViewControllerFactory)
        appCoordinator.didFinishLaunching(withWindow: _window)
        
        _window.makeKeyAndVisible()
        
        return true
    }
}
