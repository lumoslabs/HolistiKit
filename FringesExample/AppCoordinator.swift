class AppCoordinator {

    let router: RootRouter

    init(examplesNavigationControllerFactory: ExamplesNavigationControllingFactoryProtocol,
         examplesViewControllerFactory: ExamplesViewControllingFactoryProtocol,
         timerViewControllerFactory: TimerViewControllerFactoryProtocol,
         networkRequestViewControllerFactory: NetworkRequestViewControllerFactoryProtocol,
         dateViewControllerFactory: DateViewControllerFactoryProtocol,
         dateProvider: DateProviding,
         timeZoneProvider: TimeZoneProviding,
         errorLogger: ErrorLogging,
         networkRequestService: NetworkRequestingService,
         timerFactory: TimerFactoryProtocol) {
        let examplesNavigationPresenterFactory = ExamplesNavigationPresenterFactory(viewControllerFactory: examplesNavigationControllerFactory)
        let examplesPresenterFactory = ExamplesPresenterFactory(viewControllerFactory: examplesViewControllerFactory,
                                                                  errorLogger: errorLogger)
        let timerPresenterFactory = TimerPresenterFactory(viewControllerFactory: timerViewControllerFactory,
                                                          dateProvider: dateProvider,
                                                          timeZoneProvider: timeZoneProvider,
                                                          timerFactory: timerFactory)
        let networkRequestPresenterFactory = NetworkRequestPresenterFactory(viewControllerFactory: networkRequestViewControllerFactory,
                                                                            networkRequestService: networkRequestService,
                                                                            errorLogger: errorLogger)
        let datePresenterFactory = DatePresenterFactory(viewControllerFactory: dateViewControllerFactory,
                                                                dateProvider: dateProvider,
                                                                timeZoneProvider: timeZoneProvider)
        self.router = RootRouter(examplesNavigationPresenterFactory: examplesNavigationPresenterFactory,
                                 examplesPresenterFactory: examplesPresenterFactory,
                                 timerPresenterFactory: timerPresenterFactory,
                                 networkRequestPresenterFactory: networkRequestPresenterFactory,
                                 datePresenterFactory: datePresenterFactory)
    }
    
    func didFinishLaunching(withWindow window: Windowing) {
        router.present(onWindow: window)
    }
}
