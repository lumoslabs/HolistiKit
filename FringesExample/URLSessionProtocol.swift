import Foundation

extension URLSession: URLSessionProtocol {

    func urlDataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return dataTask(with: url, completionHandler: completionHandler)
    }
}

protocol URLSessionProtocol {

    func urlDataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }

protocol URLSessionDataTaskProtocol {
    
    var state: URLSessionTask.State { get }
    func resume()
}
