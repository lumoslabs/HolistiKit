import Foundation

public struct SpecURLRequestIdentifier {

    let url: String
    let method: HTTPMethod

    public init(url: String, method: HTTPMethod) {
        self.url = url
        self.method = method
    }

    public enum HTTPMethod: String, CustomStringConvertible {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"

        public var description: String { return rawValue }
    }
}

extension SpecURLRequestIdentifier: CustomStringConvertible {

    public var description: String {
        return "(\(url), \(method))"
    }
}

func ==(lhs: SpecURLRequestIdentifier, rhs: SpecURLRequestIdentifier) -> Bool {
    return lhs.url == rhs.url &&
        lhs.method.rawValue == rhs.method.rawValue
}

func ==(lhs: SpecURLRequestIdentifier, rhs: SpecURLSessionDataTask) -> Bool {
    return lhs.url == rhs.originalRequest?.url?.absoluteString &&
        lhs.method.rawValue == rhs.originalRequest?.httpMethod
}

func ==(lhs: SpecURLSessionDataTask, rhs: SpecURLRequestIdentifier) -> Bool {
    return rhs == lhs
}
