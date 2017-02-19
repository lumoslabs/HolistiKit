import Foundation
import UIKitFringes

public class SpecURLSessionDataTask: URLSessionDataTaskProtocol {

    public typealias Handler = (Data?, URLResponse?, Error?) -> Void

    let url: SpecURLSession.RequestURL
    public var state: URLSessionTask.State = .suspended
    private let handler: Handler

    init(url: SpecURLSession.RequestURL, handler: @escaping Handler) {
        self.url = url
        self.handler = handler
    }

    public func resume() {
        state = .running
    }

    func finish(withResponse response: SpecURLSession.Response) {
        state = .completed
        switch response {
        case .success(let data, let urlResponse):
            handler(data, urlResponse, nil)
        }
    }
}

extension Array where Element: SpecURLSessionDataTask {

    var running: [Element] {
        return filter { $0.state == .running }
    }

    func with(url: SpecURLSession.RequestURL) -> [Element] {
        return filter { $0.url == url }
    }
}
