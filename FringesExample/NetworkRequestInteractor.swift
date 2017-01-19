import Foundation

class NetworkRequestInteractor {

    weak var delegate: NetworkRequestInteractorDelegate? {
        didSet { startRequest() }
    }

    private let networkRequestService: NetworkRequestingService
    private let errorLogger: ErrorLogging

    init(networkRequestService: NetworkRequestingService,
         errorLogger: ErrorLogging) {
        self.networkRequestService = networkRequestService
        self.errorLogger = errorLogger
    }

    private func startRequest() {
        let url = "https://httpbin.org/get"
        networkRequestService.request(url) { [weak self] response in
            switch response {
            case .success(let data):
                self?.delegate?.received(data: data)
            case .error:
                self?.errorLogger.log("We haven't implemented error handling in the interactor yet.")
            }
        }
    }
}

protocol NetworkRequestInteractorDelegate: class {

    func received(data: [String : Any])
}
