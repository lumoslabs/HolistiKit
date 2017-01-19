@testable import FringesExample
    
class SpecNetworkRequestService {

    struct Request {
        let url: RequestURL
        let handler: (NetworkRequestService.Response) -> Void
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

    func respond(to urlRequest: SpecNetworkRequestService.RequestURL, with response: NetworkRequestService.Response) {
        let index = requests.index { $0.url == urlRequest }
        guard let validIndex = index else {
            fatalError("There was no request for \(urlRequest) in the app at the moment.")
        }
        let request = requests.remove(at: validIndex)
        request.handler(response)
    }
}

extension SpecNetworkRequestService: NetworkRequestingService {
    
    func request(_ urlString: String, handler: @escaping (NetworkRequestService.Response) -> Void) {
        let requestURL = RequestURL(urlString)
        let request = Request(url: requestURL,
                              handler: handler)
        requests.append(request)
    }
}
