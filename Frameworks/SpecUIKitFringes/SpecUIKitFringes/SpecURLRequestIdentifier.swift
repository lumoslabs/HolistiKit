import Foundation

public struct SpecURLRequestIdentifier {

    let url: String
    let method: HTTPMethod

    enum HTTPMethod {
        case get
        case post
        case put
        case delete
    }
}
