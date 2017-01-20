import Foundation

class NetworkRequestInteractor {

    weak var delegate: NetworkRequestInteractorDelegate? {
        didSet { startRequest() }
    }

    private let networkRequestService: NetworkRequestingService
    private let errorLogger: ErrorLogging
    private let networkActivityManager: NetworkActivityManager

    init(networkRequestService: NetworkRequestingService,
         errorLogger: ErrorLogging,
         networkActivityManager: NetworkActivityManager) {
        self.networkRequestService = networkRequestService
        self.errorLogger = errorLogger
        self.networkActivityManager = networkActivityManager
    }

    private func startRequest() {
        networkActivityManager.activityStarted()
        let url = "https://httpbin.org/get"
        networkRequestService.request(url) { [weak self] response in
            self?.networkActivityManager.activityFinished()
            switch response {
            case .success(let data):
                self?.delegate?.received(data: data)
            case .error:
                self?.errorLogger.log("We haven't implemented error handling in the interactor yet.")
            }
        }
    }
}
