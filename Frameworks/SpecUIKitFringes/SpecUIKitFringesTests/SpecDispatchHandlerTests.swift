import XCTest
import SpecUIKitFringes

class SpecDispatchHandlerTests: XCTestCase {

    var subject: SpecDispatchHandler!
    var queue: DispatchQueue!
    var dateProvider: SpecDateProvider!
    
    override func setUp() {
        super.setUp()
        dateProvider = SpecDateProvider()
        subject = SpecDispatchHandler(dateProvider: dateProvider)
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

    func test_asyncAfter() {
        var callbackExecuted = false
        let timeInterval: TimeInterval = 2
        subject.async(on: queue, after: timeInterval) { callbackExecuted = true }
        XCTAssertFalse(callbackExecuted)
        // after 1 second, still not executed
        dateProvider.progress(seconds: 1)
        XCTAssertFalse(callbackExecuted)
        // after 2 seconds, executed!
        dateProvider.progress(seconds: 1)
        XCTAssertTrue(callbackExecuted)
        // just to be sure, it won't fire again later
        callbackExecuted = false
        dateProvider.progress(seconds: 3)
        XCTAssertFalse(callbackExecuted)
    }
}
