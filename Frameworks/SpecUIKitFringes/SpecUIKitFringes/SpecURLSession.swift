import Foundation
import UIKitFringes

public class SpecURLSession: URLSessionProtocol {

    public convenience init() {
        let errorHandler = SpecErrorHandler()
        self.init(errorHandler: errorHandler)
    }

    private let errorHandler: SpecErrorHandler

    init(errorHandler: SpecErrorHandler) {
        self.errorHandler = errorHandler
    }
    
    private var requests = [SpecURLSessionDataTask]()

    public func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let request = SpecURLSessionDataTask(request: request, completionHandler: completionHandler)
        requests.append(request)
        return request
    }

    public func respond(to requestIdentifier: SpecURLRequestIdentifier, with response: SpecURLSessionDataTask.Response) {
        respond(to: requestIdentifier) { _ in return response }
    }

    public func respond(to requestIdentifier: SpecURLRequestIdentifier, using callback: (URLRequest) -> SpecURLSessionDataTask.Response) {
        let runningRequests = requests.running
        guard let matchingRequest = runningRequests.matching(requestIdentifier).first else {
            errorHandler.error(.noSuchURLRequestInProgress(requestIdentifier, runningRequests))
            return
        }
        let response = callback(matchingRequest.originalRequest!)
        matchingRequest.finish(withResponse: response)
    }
    
    private func firstRunningRequest(for requestIdentifier: SpecURLRequestIdentifier) -> SpecURLSessionDataTask? {
        return requests.running.matching(requestIdentifier).first
    }
}
