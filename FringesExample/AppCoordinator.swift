class AppCoordinator {

    let router: RootRouter

    init(dashboardViewControllerFactory: DashboardViewControllingFactoryProtocol,
         settingsViewControllerFactory: SettingsViewControllerFactoryProtocol) {
        let dashboardInteractor = DashboardInteractor()
        let dashboardPresenter = DashboardPresenter(viewControllerFactory: dashboardViewControllerFactory,
                                                    interactor: dashboardInteractor)
        let settingsPresenter = SettingsPresenter(viewControllerFactory: settingsViewControllerFactory)
        self.router = RootRouter(dashboardPresenter: dashboardPresenter,
                                 settingsPresenter: settingsPresenter)
        dashboardPresenter.set(router: router)
    }
    
    func didFinishLaunching(withWindow window: Windowing) {
        router.present(onWindow: window)
    }
}
