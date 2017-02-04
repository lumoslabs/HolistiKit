class ExamplesPresenterFactory {

    private let viewControllerFactory: ExamplesViewControllingFactoryProtocol
    private let errorLogger: ErrorLogging

    init(viewControllerFactory: ExamplesViewControllingFactoryProtocol,
         errorLogger: ErrorLogging) {
        self.viewControllerFactory = viewControllerFactory
        self.errorLogger = errorLogger
    }

    func create(withRouter router: ExamplesRouter) -> ExamplesPresenter {
        return ExamplesPresenter(viewControllerFactory: viewControllerFactory,
                                  router: router,
                                  errorLogger: errorLogger)
    }

}
