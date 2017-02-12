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
        let examplesNavigationModuleFactory = ExamplesNavigationModuleFactory(viewControllerFactory: examplesNavigationControllerFactory)
        let examplesModuleFactory = ExamplesModuleFactory(viewControllerFactory: examplesViewControllerFactory,
                                                                errorLogger: errorLogger)
        let timerModuleFactory = TimerModuleFactory(viewControllerFactory: timerViewControllerFactory,
                                                          dateProvider: dateProvider,
                                                          timeZoneProvider: timeZoneProvider,
                                                          timerFactory: timerFactory)
        let urlSessionModuleFactory = URLSessionModuleFactory(viewControllerFactory: urlSessionViewControllerFactory,
                                                                            errorLogger: errorLogger,
                                                                            networkActivityManager: networkActivityManager,
                                                                            urlSession: urlSession)
        let dateModuleFactory = DateModuleFactory(viewControllerFactory: dateViewControllerFactory,
                                                        dateProvider: dateProvider,
                                                        timeZoneProvider: timeZoneProvider)
        let uiViewControllerModuleFactory = UIViewControllerModuleFactory(viewControllerFactory: uiViewControllerViewControllerFactory,
                                                                                errorLogger: errorLogger)
        self.router = RootRouter(examplesNavigationModuleFactory: examplesNavigationModuleFactory,
                                 examplesModuleFactory: examplesModuleFactory,
                                 timerModuleFactory: timerModuleFactory,
                                 urlSessionModuleFactory: urlSessionModuleFactory,
                                 dateModuleFactory: dateModuleFactory,
                                 uiViewControllerModuleFactory: uiViewControllerModuleFactory)
    }
    
    func didFinishLaunching(withWindow window: Windowing) {
        router.present(onWindow: window)
    }
}
