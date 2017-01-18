class NetworkRequestPresenterFactory {

    let viewControllerFactory: NetworkRequestViewControllerFactoryProtocol

    init(viewControllerFactory: NetworkRequestViewControllerFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
    }

    func create(withRouter router: ExamplesRouter) -> NetworkRequestPresenter {
        return NetworkRequestPresenter(viewControllerFactory: viewControllerFactory)
    }
}
