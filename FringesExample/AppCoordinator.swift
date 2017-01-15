class AppCoordinator {

    let router: RootRouter

    init(dashboardNavigationControllerFactory: DashboardNavigationControllingFactoryProtocol,
         dashboardViewControllerFactory: DashboardViewControllingFactoryProtocol,
         settingsViewControllerFactory: SettingsViewControllerFactoryProtocol,
         dateProvider: DateProviding,
         timeZoneProvider: TimeZoneProviding) {
        let dashboardNavigationPresenterFactory = DashboardNavigationPresenterFactory(viewControllerFactory: dashboardNavigationControllerFactory)
        let dashboardPresenterFactory = DashboardPresenterFactory(viewControllerFactory: dashboardViewControllerFactory)
        let settingsPresenterFactory = SettingsPresenterFactory(viewControllerFactory: settingsViewControllerFactory,
                                                                dateProvider: dateProvider,
                                                                timeZoneProvider: timeZoneProvider)
        self.router = RootRouter(dashboardNavigationPresenterFactory: dashboardNavigationPresenterFactory,
                                 dashboardPresenterFactory: dashboardPresenterFactory,
                                 settingsPresenterFactory: settingsPresenterFactory)
    }
    
    func didFinishLaunching(withWindow window: Windowing) {
        router.present(onWindow: window)
    }
}
