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
        subject.respond(to: requestIdentifier, with: (data, urlResponse, nil))
        
        XCTAssertEqual(receivedData, data)
        XCTAssertEqual(receivedURLResponse, urlResponse)
        XCTAssertNil(receivedError)
    }

    func test_respondingToARequestWithMatchingHTTPMethod() {
        let urlString = "http://www.google.com"
        let url = URL(string: urlString)!
        
        var respondedToTask1 = false
        var request1 = URLRequest(url: url)
        request1.httpMethod = "GET"
        let task1 = subject.dataTask(with: request1) { _ in respondedToTask1 = true }
        task1.resume()
        
        var respondedToTask2 = false
        var request2 = URLRequest(url: url)
        request2.httpMethod = "POST"
        let task2 = subject.dataTask(with: request2) { _ in respondedToTask2 = true }
        task2.resume()
        
        var respondedToTask3 = false
        var request3 = URLRequest(url: url)
        request3.httpMethod = "GET"
        let task3 = subject.dataTask(with: request3) { _ in respondedToTask3 = true }
        task3.resume()

        let requestIdentifier = SpecURLRequestIdentifier(url: urlString, method: .post)
        let data = "blah".data(using: .utf8)!
        let urlResponse = URLResponse(url: url, mimeType: nil, expectedContentLength: 1, textEncodingName: nil)
        subject.respond(to: requestIdentifier, with: (data, urlResponse, nil))

        XCTAssertFalse(respondedToTask1)
        XCTAssertTrue(respondedToTask2)
        XCTAssertFalse(respondedToTask3)
    }

    func test_respondingToANonExistentRequest() {
        let requestIdentifier = SpecURLRequestIdentifier(url: "http://www.google.com", method: .get)
        let url = URL(string: "http://www.google.com")!
        let urlResponse = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        errorHandler.fatalErrorsOff {
            subject.respond(to: requestIdentifier, with: (Data(), urlResponse, nil))
        }
        XCTAssertEqual(errorHandler.recordedError, .noSuchURLRequestInProgress(requestIdentifier, []))
    }
}
