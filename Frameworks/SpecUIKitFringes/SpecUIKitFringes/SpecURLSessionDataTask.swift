import Foundation
import UIKitFringes

public class SpecURLSessionDataTask: URLSessionDataTask {

    public typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    private let completionHandler: CompletionHandler

    private let _originalRequest: URLRequest?
    public override var originalRequest: URLRequest? { return _originalRequest }

    private var _state: URLSessionTask.State = .suspended
    override public var state: URLSessionTask.State { return _state }

    init(request: URLRequest, completionHandler: @escaping CompletionHandler) {
        self._originalRequest = request
        self.completionHandler = completionHandler
    }

    public override func resume() {
        _state = .running
    }

    func finish(withResponse response: SpecURLSession.Response) {
        _state = .completed
        switch response {
        case .success(let data, let urlResponse):
            completionHandler(data, urlResponse, nil)
        }
    }
}

extension Array where Element: SpecURLSessionDataTask {

    var running: [Element] {
        return filter { $0.state == .running }
    }

    func matching(_ requestIdentifier: SpecURLRequestIdentifier) -> [Element] {
        return filter { $0.originalRequest?.url?.absoluteString == requestIdentifier.url }
    }
}
