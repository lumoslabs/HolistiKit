class ExamplesPresenterFactory {

    private let viewControllerFactory: ExamplesViewControllingFactoryProtocol
    private let errorLogger: ErrorLogging

    init(viewControllerFactory: ExamplesViewControllingFactoryProtocol,
         errorLogger: ErrorLogging) {
        self.viewControllerFactory = viewControllerFactory
        self.errorLogger = errorLogger
    }

    func create(withRouter router: ExamplesRouter) -> ExamplesPresenter {
        let interactor = ExamplesInteractor()
        return ExamplesPresenter(viewControllerFactory: viewControllerFactory,
                                  interactor: interactor,
                                  router: router,
                                  errorLogger: errorLogger)
    }

}
