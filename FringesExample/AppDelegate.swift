import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let _window = UIWindow(frame: UIScreen.main.bounds)
        window = _window

        let router = RootRouter()
        let appCoordinator = AppCoordinator(router: router)
        appCoordinator.didFinishLaunching(withWindow: _window)
        
        window?.makeKeyAndVisible()
        
        return true
    }
}
