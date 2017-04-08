import Foundation

public struct SpecURLRequestIdentifier {

    let url: String
    let method: HTTPMethod

    public init(url: String, method: HTTPMethod) {
        self.url = url
        self.method = method
    }

    public enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
}

func ==(lhs: SpecURLRequestIdentifier, rhs: SpecURLSessionDataTask) -> Bool {
    return lhs.url == rhs.originalRequest?.url?.absoluteString &&
        lhs.method.rawValue == rhs.originalRequest?.httpMethod
}

func ==(lhs: SpecURLSessionDataTask, rhs: SpecURLRequestIdentifier) -> Bool {
    return rhs == lhs
}
