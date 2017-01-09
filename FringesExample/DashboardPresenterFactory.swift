class DashboardPresenterFactory {

    let viewControllerFactory: DashboardViewControllingFactoryProtocol

    init(viewControllerFactory: DashboardViewControllingFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
    }

    func create(withRouter router: RootRouter) -> DashboardPresenter {
        let interactor = DashboardInteractor()
        let presenter = DashboardPresenter(viewControllerFactory: viewControllerFactory,
                                           interactor: interactor)
        presenter.set(router: router)
        return presenter
    }

}
