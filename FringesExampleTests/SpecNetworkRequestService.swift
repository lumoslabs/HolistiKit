@testable import FringesExample
    
class SpecNetworkRequestService {

    class Request: NetworkRequestProtocol {
        let url: RequestURL
        let handler: (NetworkRequestService.Response) -> Void
        var status: Status = .running

        init(url: RequestURL, handler: @escaping (NetworkRequestService.Response) -> Void) {
            self.url = url
            self.handler = handler
        }

        func cancel() {
            status = .cancelled
        }

        enum Status {
            case running
            case finished
            case cancelled
        }
    }

    enum RequestURL: String {
        case httpbin = "https://httpbin.org/get"

        init(_ rawValue: String) {
            let request = RequestURL(rawValue: rawValue)
            if let request = request {
                self = request
            } else {
                fatalError("The app is making an unhandled request for \(rawValue).\n" +
                    "Add an enum case for it and start faking success and failure responses in the tests.")
            }
        }
    }

    fileprivate var requests = [Request]()

    fileprivate func firstRunningRequest(forURL url: SpecNetworkRequestService.RequestURL) -> SpecNetworkRequestService.Request? {
        return requests.running.with(url: url).first
    }

    func respond(to url: SpecNetworkRequestService.RequestURL, with response: NetworkRequestService.Response) {
        guard let request = firstRunningRequest(forURL: url) else {
            fatalError("There was no request for \(url) in the app at the moment.")
        }
        request.status = .finished
        request.handler(response)
    }
}

extension Array where Element: SpecNetworkRequestService.Request {

    fileprivate var running: [Element] {
        return filter { $0.status == .running }
    }

    fileprivate func with(url: SpecNetworkRequestService.RequestURL) -> [Element] {
        return filter { $0.url == url }
    }
}

extension SpecNetworkRequestService: NetworkRequestingService {

    func request(_ urlString: String, handler: @escaping (NetworkRequestService.Response) -> Void) -> NetworkRequestProtocol {
        let requestURL = RequestURL(urlString)
        let request = Request(url: requestURL, handler: handler)
        requests.append(request)
        return request
    }
}
