import Foundation
import UIKitFringes

public class SpecURLSession: URLSessionProtocol {

    public init() { }
    
    private var requests = [SpecURLSessionDataTask]()

    public func urlDataTask(with url: URL, completionHandler: @escaping SpecURLSessionDataTask.Handler) -> URLSessionDataTaskProtocol {
        let requestURL = RequestURL(url.absoluteString)
        let request = SpecURLSessionDataTask(url: requestURL, handler: completionHandler)
        requests.append(request)
        return request
    }

    public func respond(to url: RequestURL, with response: Response) {
        guard let request = firstRunningRequest(forURL: url) else {
            fatalError("There was no request for \(url.rawValue) in the app at the moment.")
        }
        request.finish(withResponse: response)
    }
    
    private func firstRunningRequest(forURL url: RequestURL) -> SpecURLSessionDataTask? {
        return requests.running.with(url: url).first
    }
}

extension SpecURLSession {
    
    public enum RequestURL: String {
        case json = "https://httpbin.org/delay/3"
        case html = "https://httpbin.org/html"

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

    public enum Response {
        case success(Data, URLResponse)
    }
}
