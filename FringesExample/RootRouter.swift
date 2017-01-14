class RootRouter {

    private let dashboardRouter: DashboardRouter

    init(dashboardNavigationPresenterFactory: DashboardNavigationPresenterFactory,
         dashboardPresenterFactory: DashboardPresenterFactory,
         settingsPresenterFactory: SettingsPresenterFactory) {
        self.dashboardRouter = DashboardRouter(dashboardNavigationPresenterFactory: dashboardNavigationPresenterFactory,
                                               dashboardPresenterFactory: dashboardPresenterFactory,
                                               settingsPresenterFactory: settingsPresenterFactory)
    }
    
    func present(onWindow window: Windowing) {
        dashboardRouter.present(onWindow: window)
    }
}
