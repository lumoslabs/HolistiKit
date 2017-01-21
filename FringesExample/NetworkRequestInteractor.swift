import Foundation

class NetworkRequestInteractor {

    weak var delegate: NetworkRequestInteractorDelegate? {
        didSet { startRequest() }
    }

    private let networkRequestService: NetworkRequestingService
    private let errorLogger: ErrorLogging
    private let networkActivityManager: NetworkActivityManager
    private var request: NetworkRequestProtocol?
    private var networkActivity: NetworkActivityManager.Activity?

    init(networkRequestService: NetworkRequestingService,
         errorLogger: ErrorLogging,
         networkActivityManager: NetworkActivityManager) {
        self.networkRequestService = networkRequestService
        self.errorLogger = errorLogger
        self.networkActivityManager = networkActivityManager
    }

    private func startRequest() {
        networkActivity = networkActivityManager.activityStarted()
        let url = "https://httpbin.org/get"
        request = networkRequestService.request(url) { [weak self] response in
            self?.networkActivity?.finish()
            switch response {
            case .success(let data):
                self?.delegate?.received(data: data)
            case .error:
                self?.errorLogger.log("We haven't implemented error handling in the interactor yet.")
            }
        }
    }

    deinit {
        networkActivity?.finish()
    }
}
