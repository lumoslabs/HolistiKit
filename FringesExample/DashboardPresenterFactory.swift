class DashboardPresenterFactory {

    let viewControllerFactory: DashboardViewControllingFactoryProtocol

    init(viewControllerFactory: DashboardViewControllingFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
    }

    func create(withRouter router: DashboardRouter) -> DashboardPresenter {
        let interactor = DashboardInteractor()
        return DashboardPresenter(viewControllerFactory: viewControllerFactory,
                                  interactor: interactor,
                                  router: router)
    }

}
