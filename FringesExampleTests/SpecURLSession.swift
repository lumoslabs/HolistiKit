import Foundation
@testable import FringesExample

class SpecURLSession: URLSessionProtocol {
    
    private var requests = [SpecURLSessionDataTask]()

    func urlDataTask(with url: URL, completionHandler: @escaping SpecURLSessionDataTask.Handler) -> URLSessionDataTaskProtocol {
        let requestURL = RequestURL(url.absoluteString)
        let request = SpecURLSessionDataTask(url: requestURL, handler: completionHandler)
        requests.append(request)
        return request
    }

    func respond(to url: RequestURL, with response: Response) {
        guard let request = firstRunningRequest(forURL: url) else {
            fatalError("There was no request for \(url) in the app at the moment.")
        }
        request.finish(withResponse: response)
    }
    
    private func firstRunningRequest(forURL url: RequestURL) -> SpecURLSessionDataTask? {
        return requests.running.with(url: url).first
    }
}

extension SpecURLSession {
    
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

    enum Response {
        case success(Data)
    }
}
