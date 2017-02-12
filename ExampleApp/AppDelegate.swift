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
        let urlSessionViewControllerFactory = URLSessionViewControllerFactory()
        let dateViewControllerFactory = DateViewControllerFactory()
        let uiViewControllerViewControllerFactory = UIViewControllerViewControllerFactory()
        let dateProvider = DateProvider()
        let timeZoneProvider = TimeZoneProvider()
        let errorLogger = ErrorLogger()
        let timerFactory = TimerFactory()
        let sharedApplication = UIApplication.shared
        let urlSession = URLSession.shared
        let appCoordinator = AppCoordinator(examplesNavigationControllerFactory: examplesNavigationControllerFactory,
                                            examplesViewControllerFactory: examplesViewControllerFactory,
                                            timerViewControllerFactory: timerViewControllerFactory,
                                            urlSessionViewControllerFactory: urlSessionViewControllerFactory,
                                            dateViewControllerFactory: dateViewControllerFactory,
                                            uiViewControllerViewControllerFactory: uiViewControllerViewControllerFactory,
                                            dateProvider: dateProvider,
                                            timeZoneProvider: timeZoneProvider,
                                            errorLogger: errorLogger,
                                            timerFactory: timerFactory,
                                            sharedApplication: sharedApplication,
                                            urlSession: urlSession)
        appCoordinator.didFinishLaunching(withWindow: _window)

        _window.makeKeyAndVisible()
        return true
    }
}
