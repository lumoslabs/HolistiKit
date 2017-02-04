class ExamplesNavigationPresenterFactory {

    let viewControllerFactory: ExamplesNavigationControllingFactoryProtocol

    init(viewControllerFactory: ExamplesNavigationControllingFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
    }

    func create(withRouter router: ExamplesRouter) -> ExamplesNavigationPresenter {
        return ExamplesNavigationPresenter(viewControllerFactory: viewControllerFactory,
                                            router: router)
    }
}
