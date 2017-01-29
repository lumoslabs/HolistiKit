import UIKitFringes

class AppCoordinator {

    let router: RootRouter

    init(examplesNavigationControllerFactory: ExamplesNavigationControllingFactoryProtocol,
         examplesViewControllerFactory: ExamplesViewControllingFactoryProtocol,
         timerViewControllerFactory: TimerViewControllerFactoryProtocol,
         urlSessionViewControllerFactory: URLSessionViewControllerFactoryProtocol,
         dateViewControllerFactory: DateViewControllerFactoryProtocol,
         uiViewControllerViewControllerFactory: UIViewControllerViewControllerFactoryProtocol,
         dateProvider: DateProviding,
         timeZoneProvider: TimeZoneProviding,
         errorLogger: ErrorLogging,
         timerFactory: TimerFactoryProtocol,
         sharedApplication: ApplicationProtocol,
         urlSession: URLSessionProtocol) {
        let networkActivityManager = NetworkActivityManager(sharedApplication: sharedApplication)
        let examplesNavigationPresenterFactory = ExamplesNavigationPresenterFactory(viewControllerFactory: examplesNavigationControllerFactory)
        let examplesPresenterFactory = ExamplesPresenterFactory(viewControllerFactory: examplesViewControllerFactory,
                                                                errorLogger: errorLogger)
        let timerPresenterFactory = TimerPresenterFactory(viewControllerFactory: timerViewControllerFactory,
                                                          dateProvider: dateProvider,
                                                          timeZoneProvider: timeZoneProvider,
                                                          timerFactory: timerFactory)
        let urlSessionPresenterFactory = URLSessionPresenterFactory(viewControllerFactory: urlSessionViewControllerFactory,
                                                                            errorLogger: errorLogger,
                                                                            networkActivityManager: networkActivityManager,
                                                                            urlSession: urlSession)
        let datePresenterFactory = DatePresenterFactory(viewControllerFactory: dateViewControllerFactory,
                                                        dateProvider: dateProvider,
                                                        timeZoneProvider: timeZoneProvider)
        let uiViewControllerPresenterFactory = UIViewControllerPresenterFactory(viewControllerFactory: uiViewControllerViewControllerFactory,
                                                                                errorLogger: errorLogger)
        self.router = RootRouter(examplesNavigationPresenterFactory: examplesNavigationPresenterFactory,
                                 examplesPresenterFactory: examplesPresenterFactory,
                                 timerPresenterFactory: timerPresenterFactory,
                                 urlSessionPresenterFactory: urlSessionPresenterFactory,
                                 datePresenterFactory: datePresenterFactory,
                                 uiViewControllerPresenterFactory: uiViewControllerPresenterFactory)
    }
    
    func didFinishLaunching(withWindow window: Windowing) {
        router.present(onWindow: window)
    }
}
