class RootRouter {

    private let dashboardPresenterFactory: DashboardPresenterFactory
    private let settingsPresenterFactory: SettingsPresenterFactory

    init(dashboardPresenterFactory: DashboardPresenterFactory,
         settingsPresenterFactory: SettingsPresenterFactory) {
        self.dashboardPresenterFactory = dashboardPresenterFactory
        self.settingsPresenterFactory = settingsPresenterFactory
    }
    
    func present(onWindow window: Windowing) {
        let dashboardPresenter = dashboardPresenterFactory.create(withRouter: self)
        dashboardPresenter.present(onWindow: window)
    }
    
    func presentSettingsPage(onPresenter presenter: DashboardPresenter) {
        let settingsPresenter = settingsPresenterFactory.create(withRouter: self)
        settingsPresenter.present(onPresenter: presenter)
    }
}
