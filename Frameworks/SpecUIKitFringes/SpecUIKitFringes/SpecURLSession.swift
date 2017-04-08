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

    public func respond(to requestIdentifier: SpecURLRequestIdentifier, with response: Response) {
        guard let request = firstRunningRequest(for: requestIdentifier) else {
            errorHandler.error(.noSuchURLRequestInProgress)
            return
        }
        request.finish(withResponse: response)
    }
    
    private func firstRunningRequest(for requestIdentifier: SpecURLRequestIdentifier) -> SpecURLSessionDataTask? {
        return requests.running.matching(requestIdentifier).first
    }
}

extension SpecURLSession {

    public enum Response {
        case success(Data, URLResponse)
    }
}
