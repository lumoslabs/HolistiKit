class NetworkRequestPresenterFactory {

    private let viewControllerFactory: NetworkRequestViewControllerFactoryProtocol
    private let networkRequestService: NetworkRequestingService
    private let errorLogger: ErrorLogging
    private let networkActivityManager: NetworkActivityManager
    
    init(viewControllerFactory: NetworkRequestViewControllerFactoryProtocol,
         networkRequestService: NetworkRequestingService,
         errorLogger: ErrorLogging,
         networkActivityManager: NetworkActivityManager) {
        self.viewControllerFactory = viewControllerFactory
        self.networkRequestService = networkRequestService
        self.errorLogger = errorLogger
        self.networkActivityManager = networkActivityManager
    }

    func create(withRouter router: ExamplesRouter) -> NetworkRequestPresenter {
        let interactor = NetworkRequestInteractor(networkRequestService: networkRequestService,
                                                  errorLogger: errorLogger,
                                                  networkActivityManager: networkActivityManager)
        return NetworkRequestPresenter(viewControllerFactory: viewControllerFactory,
                                       interactor: interactor)
    }
}
