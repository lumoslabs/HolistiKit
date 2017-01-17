import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let _window = UIWindow(frame: UIScreen.main.bounds)
        window = _window

        let examplesNavigationControllerFactory = ExamplesNavigationControllingFactory()
        let examplesViewControllerFactory = ExamplesViewControllingFactory()
        let timerViewControllerFactory = TimerViewControllerFactory()
        let dateViewControllerFactory = DateViewControllerFactory()
        let dateProvider = DateProvider()
        let timeZoneProvider = TimeZoneProvider()
        let errorLogger = ErrorLogger()
        let timerFactory = TimerFactory()
        let appCoordinator = AppCoordinator(examplesNavigationControllerFactory: examplesNavigationControllerFactory,
                                            examplesViewControllerFactory: examplesViewControllerFactory,
                                            timerViewControllerFactory: timerViewControllerFactory,
                                            dateViewControllerFactory: dateViewControllerFactory,
                                            dateProvider: dateProvider,
                                            timeZoneProvider: timeZoneProvider,
                                            errorLogger: errorLogger,
                                            timerFactory: timerFactory)
        appCoordinator.didFinishLaunching(withWindow: _window)
        
        _window.makeKeyAndVisible()
        return true
    }
}
