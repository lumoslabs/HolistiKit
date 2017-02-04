class URLSessionPresenterFactory {

    private let viewControllerFactory: URLSessionViewControllerFactoryProtocol
    private let errorLogger: ErrorLogging
    private let networkActivityManager: NetworkActivityManager
    private let urlSession: URLSessionProtocol

    init(viewControllerFactory: URLSessionViewControllerFactoryProtocol,
         errorLogger: ErrorLogging,
         networkActivityManager: NetworkActivityManager,
         urlSession: URLSessionProtocol) {
        self.viewControllerFactory = viewControllerFactory
        self.errorLogger = errorLogger
        self.networkActivityManager = networkActivityManager
        self.urlSession = urlSession
    }

    func create(withRouter router: ExamplesRouter) -> URLSessionPresenter {
        let interactor = URLSessionInteractor(errorLogger: errorLogger,
                                              networkActivityManager: networkActivityManager,
                                              urlSession: urlSession)
        return URLSessionPresenter(viewControllerFactory: viewControllerFactory,
                                   interactor: interactor,
                                   errorLogger: errorLogger)
    }
}
