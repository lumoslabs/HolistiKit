class AppCoordinator {

    let router: RootRouter

    init(dashboardViewControllerFactory: DashboardViewControllingFactoryProtocol,
         settingsViewControllerFactory: SettingsViewControllerFactoryProtocol) {
        let dashboardPresenterFactory = DashboardPresenterFactory(viewControllerFactory: dashboardViewControllerFactory)
        let settingsPresenterFactory = SettingsPresenterFactory(viewControllerFactory: settingsViewControllerFactory)
        self.router = RootRouter(dashboardPresenterFactory: dashboardPresenterFactory,
                                 settingsPresenterFactory: settingsPresenterFactory)
    }
    
    func didFinishLaunching(withWindow window: Windowing) {
        router.present(onWindow: window)
    }
}
