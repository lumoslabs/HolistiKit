class DashboardRouter {

    private let dashboardPresenterFactory: DashboardPresenterFactory
    private let datePresenterFactory: DatePresenterFactory
    private let dashboardNavigationPresenterFactory: DashboardNavigationPresenterFactory

    init(dashboardNavigationPresenterFactory: DashboardNavigationPresenterFactory,
         dashboardPresenterFactory: DashboardPresenterFactory,
         datePresenterFactory: DatePresenterFactory) {
        self.dashboardNavigationPresenterFactory = dashboardNavigationPresenterFactory
        self.dashboardPresenterFactory = dashboardPresenterFactory
        self.datePresenterFactory = datePresenterFactory
    }
    
    func present(onWindow window: Windowing) {
        let dashboardNavigationPresenter = dashboardNavigationPresenterFactory.create(withRouter: self)
        dashboardNavigationPresenter.present(onWindow: window)
    }

    func pushDashboard(on presenter: PushablePresenter) {
        let dashboardPresenter = dashboardPresenterFactory.create(withRouter: self)
        dashboardPresenter.push(on: presenter)
    }
    
    func pushDate(on presenter: PushablePresenter) {
        let datePresenter = datePresenterFactory.create(withRouter: self)
        datePresenter.push(on: presenter)
    }
}
