import XCTest
@testable import SpecUIKitFringes

class SpecDispatchHandlerTests: XCTestCase {

    var subject: SpecDispatchHandler!
    var queue: DispatchQueue!
    
    override func setUp() {
        super.setUp()
        subject = SpecDispatchHandler()
        queue = DispatchQueue(label: "some queue")
    }

    func test_sync() {
        var callbackExecuted = false
        subject.sync(on: queue) { callbackExecuted = true }
        XCTAssertTrue(callbackExecuted)
    }

    func test_async() {
        var callbackExecuted = false
        subject.async(on: queue) { callbackExecuted = true }
        XCTAssertTrue(callbackExecuted)
    }
}
