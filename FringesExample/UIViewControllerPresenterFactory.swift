class UIViewControllerPresenterFactory {

    private let viewControllerFactory: UIViewControllerViewControllerFactoryProtocol
    private let errorLogger: ErrorLogging
    
    init(viewControllerFactory: UIViewControllerViewControllerFactoryProtocol,
         errorLogger: ErrorLogging) {
        self.viewControllerFactory = viewControllerFactory
        self.errorLogger = errorLogger
    }

    func create(withRouter router: ExamplesRouter) -> UIViewControllerPresenter {
        return UIViewControllerPresenter(viewControllerFactory: viewControllerFactory,
                                         router: router,
                                         errorLogger: errorLogger)
    }
}
