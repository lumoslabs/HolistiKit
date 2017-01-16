class AppCoordinator {

    let router: RootRouter

    init(dashboardNavigationControllerFactory: DashboardNavigationControllingFactoryProtocol,
         dashboardViewControllerFactory: DashboardViewControllingFactoryProtocol,
         timerViewControllerFactory: TimerViewControllerFactoryProtocol,
         dateViewControllerFactory: DateViewControllerFactoryProtocol,
         dateProvider: DateProviding,
         timeZoneProvider: TimeZoneProviding,
         errorLogger: ErrorLogging) {
        let dashboardNavigationPresenterFactory = DashboardNavigationPresenterFactory(viewControllerFactory: dashboardNavigationControllerFactory)
        let dashboardPresenterFactory = DashboardPresenterFactory(viewControllerFactory: dashboardViewControllerFactory,
                                                                  errorLogger: errorLogger)
        let timerPresenterFactory = TimerPresenterFactory(viewControllerFactory: timerViewControllerFactory)
        let datePresenterFactory = DatePresenterFactory(viewControllerFactory: dateViewControllerFactory,
                                                                dateProvider: dateProvider,
                                                                timeZoneProvider: timeZoneProvider)
        self.router = RootRouter(dashboardNavigationPresenterFactory: dashboardNavigationPresenterFactory,
                                 dashboardPresenterFactory: dashboardPresenterFactory,
                                 timerPresenterFactory: timerPresenterFactory,
                                 datePresenterFactory: datePresenterFactory)
    }
    
    func didFinishLaunching(withWindow window: Windowing) {
        router.present(onWindow: window)
    }
}
