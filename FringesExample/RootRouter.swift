class RootRouter {

    private let dashboardRouter: DashboardRouter

    init(dashboardNavigationPresenterFactory: DashboardNavigationPresenterFactory,
         dashboardPresenterFactory: DashboardPresenterFactory,
         datePresenterFactory: DatePresenterFactory) {
        self.dashboardRouter = DashboardRouter(dashboardNavigationPresenterFactory: dashboardNavigationPresenterFactory,
                                               dashboardPresenterFactory: dashboardPresenterFactory,
                                               datePresenterFactory: datePresenterFactory)
    }
    
    func present(onWindow window: Windowing) {
        dashboardRouter.present(onWindow: window)
    }
}
