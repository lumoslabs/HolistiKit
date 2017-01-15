class AppCoordinator {

    let router: RootRouter

    init(dashboardNavigationControllerFactory: DashboardNavigationControllingFactoryProtocol,
         dashboardViewControllerFactory: DashboardViewControllingFactoryProtocol,
         dateViewControllerFactory: DateViewControllerFactoryProtocol,
         dateProvider: DateProviding,
         timeZoneProvider: TimeZoneProviding) {
        let dashboardNavigationPresenterFactory = DashboardNavigationPresenterFactory(viewControllerFactory: dashboardNavigationControllerFactory)
        let dashboardPresenterFactory = DashboardPresenterFactory(viewControllerFactory: dashboardViewControllerFactory)
        let datePresenterFactory = DatePresenterFactory(viewControllerFactory: dateViewControllerFactory,
                                                                dateProvider: dateProvider,
                                                                timeZoneProvider: timeZoneProvider)
        self.router = RootRouter(dashboardNavigationPresenterFactory: dashboardNavigationPresenterFactory,
                                 dashboardPresenterFactory: dashboardPresenterFactory,
                                 datePresenterFactory: datePresenterFactory)
    }
    
    func didFinishLaunching(withWindow window: Windowing) {
        router.present(onWindow: window)
    }
}
