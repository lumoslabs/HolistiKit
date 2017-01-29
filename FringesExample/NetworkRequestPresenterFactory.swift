class NetworkRequestPresenterFactory {

    private let viewControllerFactory: NetworkRequestViewControllerFactoryProtocol
    private let errorLogger: ErrorLogging
    private let networkActivityManager: NetworkActivityManager
    private let urlSession: URLSessionProtocol
    
    init(viewControllerFactory: NetworkRequestViewControllerFactoryProtocol,
         errorLogger: ErrorLogging,
         networkActivityManager: NetworkActivityManager,
         urlSession: URLSessionProtocol) {
        self.viewControllerFactory = viewControllerFactory
        self.errorLogger = errorLogger
        self.networkActivityManager = networkActivityManager
        self.urlSession = urlSession
    }

    func create(withRouter router: ExamplesRouter) -> NetworkRequestPresenter {
        let interactor = NetworkRequestInteractor(errorLogger: errorLogger,
                                                  networkActivityManager: networkActivityManager,
                                                  urlSession: urlSession)
        return NetworkRequestPresenter(viewControllerFactory: viewControllerFactory,
                                       interactor: interactor,
                                       errorLogger: errorLogger)
    }
}
