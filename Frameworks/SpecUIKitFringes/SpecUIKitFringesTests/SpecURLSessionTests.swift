import XCTest
import UIKitFringes
@testable import SpecUIKitFringes

class SpecURLSessionTests: XCTestCase {

    var subject: SpecURLSession!
    var errorHandler: SpecErrorHandler!
    
    override func setUp() {
        super.setUp()
        errorHandler = SpecErrorHandler()
        subject = SpecURLSession(errorHandler: errorHandler)
    }

    func test_respondingToARequest() {
        let url = URL(string: "http://www.google.com")!
        let request = URLRequest(url: url)
        var receivedData: Data?
        var receivedURLResponse: URLResponse?
        var receivedError: Error?
        let task = subject.dataTask(with: request) { (data, urlResponse, error) in
            receivedData = data
            receivedURLResponse = urlResponse
            receivedError = error
        }
        task.resume()

        let requestIdentifier = SpecURLRequestIdentifier(url: "http://www.google.com", method: .get)
        let data = "blah".data(using: .utf8)!
        let urlResponse = URLResponse(url: url, mimeType: nil, expectedContentLength: 1, textEncodingName: nil)
        subject.respond(to: requestIdentifier, with: .success(data, urlResponse))
        
        XCTAssertEqual(receivedData, data)
        XCTAssertEqual(receivedURLResponse, urlResponse)
        XCTAssertNil(receivedError)
    }

    func test_respondingToANonExistentRequest() {
        let requestIdentifier = SpecURLRequestIdentifier(url: "http://www.google.com", method: .get)
        let url = URL(string: "http://www.google.com")!
        let urlResponse = URLResponse(url: url, mimeType: nil, expectedContentLength: 1, textEncodingName: nil)
        let data = "blah".data(using: .utf8)!
        errorHandler.fatalErrorsOff {
            self.subject.respond(to: requestIdentifier, with: .success(data, urlResponse))
        }
        XCTAssertEqual(errorHandler.recordedError, .noSuchURLRequestInProgress)
    }
}
