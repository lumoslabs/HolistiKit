class NetworkRequestPresenterFactory {

    private let viewControllerFactory: NetworkRequestViewControllerFactoryProtocol
    private let networkRequestService: NetworkRequestingService
    private let errorLogger: ErrorLogging

    init(viewControllerFactory: NetworkRequestViewControllerFactoryProtocol,
         networkRequestService: NetworkRequestingService,
         errorLogger: ErrorLogging) {
        self.viewControllerFactory = viewControllerFactory
        self.networkRequestService = networkRequestService
        self.errorLogger = errorLogger
    }

    func create(withRouter router: ExamplesRouter) -> NetworkRequestPresenter {
        let interactor = NetworkRequestInteractor(networkRequestService: networkRequestService,
                                                  errorLogger: errorLogger)
        return NetworkRequestPresenter(viewControllerFactory: viewControllerFactory,
                                       interactor: interactor)
    }
}
