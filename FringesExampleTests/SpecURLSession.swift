import Foundation
@testable import FringesExample

class SpecURLSession: URLSessionProtocol {

    func urlDataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        let requestURL = RequestURL(url.absoluteString)
        let request = SpecURLSessionDataTask(url: requestURL, handler: completionHandler)
        requests.append(request)
        return request
    }
    
    private var requests = [SpecURLSessionDataTask]()

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
    
    fileprivate func firstRunningRequest(forURL url: RequestURL) -> SpecURLSessionDataTask? {
        return requests.running.with(url: url).first
    }
    
    func respond(to url: RequestURL, with response: Response) {
        guard let request = firstRunningRequest(forURL: url) else {
            fatalError("There was no request for \(url) in the app at the moment.")
        }
        request.state = .completed
        switch response {
        case .success(let data):
            request.handler(data, nil, nil)
        }
    }
}

extension Array where Element: SpecURLSessionDataTask {

    fileprivate var running: [Element] {
        return filter { $0.state == .running }
    }

    fileprivate func with(url: SpecURLSession.RequestURL) -> [Element] {
        return filter { $0.url == url }
    }
}

class SpecURLSessionDataTask: URLSessionDataTaskProtocol {

    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    let url: SpecURLSession.RequestURL
    let handler: Handler
    var state: URLSessionTask.State = .suspended

    init(url: SpecURLSession.RequestURL, handler: @escaping Handler) {
        self.url = url
        self.handler = handler
    }

    func resume() {
        state = .running
    }
}
