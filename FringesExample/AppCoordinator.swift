class AppCoordinator {

    let router: RootRouter

    init(dashboardNavigationControllerFactory: DashboardNavigationControllingFactoryProtocol,
         dashboardViewControllerFactory: DashboardViewControllingFactoryProtocol,
         settingsViewControllerFactory: SettingsViewControllerFactoryProtocol) {
        let dashboardNavigationPresenterFactory = DashboardNavigationPresenterFactory(viewControllerFactory: dashboardNavigationControllerFactory)
        let dashboardPresenterFactory = DashboardPresenterFactory(viewControllerFactory: dashboardViewControllerFactory)
        let settingsPresenterFactory = SettingsPresenterFactory(viewControllerFactory: settingsViewControllerFactory)
        self.router = RootRouter(dashboardNavigationPresenterFactory: dashboardNavigationPresenterFactory,
                                 dashboardPresenterFactory: dashboardPresenterFactory,
                                 settingsPresenterFactory: settingsPresenterFactory)
    }
    
    func didFinishLaunching(withWindow window: Windowing) {
        router.present(onWindow: window)
    }
}
