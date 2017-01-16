class RootRouter {

    private let dashboardRouter: DashboardRouter

    init(dashboardNavigationPresenterFactory: DashboardNavigationPresenterFactory,
         dashboardPresenterFactory: DashboardPresenterFactory,
         timerPresenterFactory: TimerPresenterFactory,
         datePresenterFactory: DatePresenterFactory) {
        self.dashboardRouter = DashboardRouter(dashboardNavigationPresenterFactory: dashboardNavigationPresenterFactory,
                                               dashboardPresenterFactory: dashboardPresenterFactory,
                                               timerPresenterFactory: timerPresenterFactory,
                                               datePresenterFactory: datePresenterFactory)
    }
    
    func present(onWindow window: Windowing) {
        dashboardRouter.present(onWindow: window)
    }
}
