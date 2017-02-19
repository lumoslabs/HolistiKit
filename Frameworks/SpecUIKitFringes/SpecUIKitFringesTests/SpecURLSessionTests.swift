import XCTest
import UIKitFringes
@testable import SpecUIKitFringes

class SpecURLSessionTests: XCTestCase {

    var subject: SpecURLSession!
    
    override func setUp() {
        super.setUp()
        subject = SpecURLSession()
    }

    func test_respondingToARequest() {
        let url = URL(string: "http://www.google.com")!
        var receivedData: Data?
        var receivedURLResponse: URLResponse?
        var receivedError: Error?
        let task = subject.urlDataTask(with: url) { (data, urlResponse, error) in
            receivedData = data
            receivedURLResponse = urlResponse
            receivedError = error
        }
        task.resume()
        let data = "blah".data(using: .utf8)!
        let urlResponse = URLResponse(url: url, mimeType: nil, expectedContentLength: 1, textEncodingName: nil)
        subject.respond(to: "http://www.google.com", with: .success(data, urlResponse))
        XCTAssertEqual(receivedData, data)
        XCTAssertEqual(receivedURLResponse, urlResponse)
        XCTAssertNil(receivedError)
    }
}
