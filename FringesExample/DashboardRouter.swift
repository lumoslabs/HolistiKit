class DashboardRouter {

    private let dashboardPresenterFactory: DashboardPresenterFactory
    private let settingsPresenterFactory: SettingsPresenterFactory
    private let dashboardNavigationPresenterFactory: DashboardNavigationPresenterFactory

    init(dashboardNavigationPresenterFactory: DashboardNavigationPresenterFactory,
         dashboardPresenterFactory: DashboardPresenterFactory,
         settingsPresenterFactory: SettingsPresenterFactory) {
        self.dashboardNavigationPresenterFactory = dashboardNavigationPresenterFactory
        self.dashboardPresenterFactory = dashboardPresenterFactory
        self.settingsPresenterFactory = settingsPresenterFactory
    }
    
    func present(onWindow window: Windowing) {
        let dashboardNavigationPresenter = dashboardNavigationPresenterFactory.create(withRouter: self)
        dashboardNavigationPresenter.present(onWindow: window)
    }

    //
    //
    // TODO make this take a (new) NavigationPresenting
    //
    func pushDashboard(on presenter: DashboardNavigationPresenter) {
        let dashboardPresenter = dashboardPresenterFactory.create(withRouter: self)
        dashboardPresenter.push(on: presenter)
    }
    
    func pushSettings(onPresenter presenter: DashboardPresenter) {
        let settingsPresenter = settingsPresenterFactory.create(withRouter: self)
        settingsPresenter.push(onPresenter: presenter)
    }
}
