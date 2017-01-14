class DashboardNavigationPresenterFactory {

    let viewControllerFactory: DashboardNavigationControllingFactoryProtocol

    init(viewControllerFactory: DashboardNavigationControllingFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
    }

    func create(withRouter router: DashboardRouter) -> DashboardNavigationPresenter {
        return DashboardNavigationPresenter(viewControllerFactory: viewControllerFactory,
                                            router: router)
    }
}
