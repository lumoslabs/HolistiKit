import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let _window = UIWindow(frame: UIScreen.main.bounds)
        window = _window

        let dashboardViewControllerFactory = DashboardViewControllingFactory()
        let dashboardPresenter = DashboardPresenter(viewControllerFactory: dashboardViewControllerFactory)
        let dashboardRouter = DashboardRouter(dashboardPresenter: dashboardPresenter)
        let router = RootRouter(dashboardRouter: dashboardRouter)
        let appCoordinator = AppCoordinator(router: router)
        appCoordinator.didFinishLaunching(withWindow: _window)
        
        _window.makeKeyAndVisible()
        
        return true
    }
}
