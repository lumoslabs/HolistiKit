class AppCoordinator {

    let router: RootRouter

    init(examplesNavigationControllerFactory: ExamplesNavigationControllingFactoryProtocol,
         examplesViewControllerFactory: ExamplesViewControllingFactoryProtocol,
         timerViewControllerFactory: TimerViewControllerFactoryProtocol,
         dateViewControllerFactory: DateViewControllerFactoryProtocol,
         dateProvider: DateProviding,
         timeZoneProvider: TimeZoneProviding,
         errorLogger: ErrorLogging,
         timerFactory: TimerFactoryProtocol) {
        let examplesNavigationPresenterFactory = ExamplesNavigationPresenterFactory(viewControllerFactory: examplesNavigationControllerFactory)
        let examplesPresenterFactory = ExamplesPresenterFactory(viewControllerFactory: examplesViewControllerFactory,
                                                                  errorLogger: errorLogger)
        let timerPresenterFactory = TimerPresenterFactory(viewControllerFactory: timerViewControllerFactory,
                                                          dateProvider: dateProvider,
                                                          timeZoneProvider: timeZoneProvider,
                                                          timerFactory: timerFactory)
        let datePresenterFactory = DatePresenterFactory(viewControllerFactory: dateViewControllerFactory,
                                                                dateProvider: dateProvider,
                                                                timeZoneProvider: timeZoneProvider)
        self.router = RootRouter(examplesNavigationPresenterFactory: examplesNavigationPresenterFactory,
                                 examplesPresenterFactory: examplesPresenterFactory,
                                 timerPresenterFactory: timerPresenterFactory,
                                 datePresenterFactory: datePresenterFactory)
    }
    
    func didFinishLaunching(withWindow window: Windowing) {
        router.present(onWindow: window)
    }
}
