import Foundation

extension URLSession: URLSessionProtocol {}

public protocol URLSessionProtocol {

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
