import XCTest
import UIKitFringes
import SpecUIKitFringes

class SpecTimerTests: XCTestCase {

    var subject: Timing!
    var factory: SpecTimerFactory!
    var dateProvider: SpecDateProvider!
    
    override func setUp() {
        super.setUp()
        dateProvider = SpecDateProvider()
        factory = SpecTimerFactory(dateProvider: dateProvider)
    }

    func test_firesAtAnInterval() {
        var firedCount = 0
        dateProvider.progress(seconds: 1)
        subject = factory.createScheduledTimer(withTimeInterval: 2, repeats: true) { firedCount += 1 }
        XCTAssertEqual(firedCount, 0)
        dateProvider.progress(seconds: 1)
        XCTAssertEqual(firedCount, 0)
        dateProvider.progress(seconds: 1)
        XCTAssertEqual(firedCount, 1)
        dateProvider.progress(seconds: 2)
        XCTAssertEqual(firedCount, 2)
    }

    func test_firesMultipleTimesIfTimeProgressionIsLongEnough() {
        var firedCount = 0
        subject = factory.createScheduledTimer(withTimeInterval: 2, repeats: true) { firedCount += 1 }
        XCTAssertEqual(firedCount, 0)
        dateProvider.progress(seconds: 4)
        XCTAssertEqual(firedCount, 2)
    }

    func test_doesNotRepeatIfConfiguredNotTo() {
        var firedCount = 0
        subject = factory.createScheduledTimer(withTimeInterval: 2, repeats: false) { firedCount += 1 }
        dateProvider.progress(seconds: 2)
        XCTAssertEqual(firedCount, 1)
        dateProvider.progress(seconds: 2)
        XCTAssertEqual(firedCount, 1)
    }

    func test_doesNotFireIfInvalidated() {
        var firedCount = 0
        subject = factory.createScheduledTimer(withTimeInterval: 2, repeats: false) { firedCount += 1 }
        subject.invalidate()
        dateProvider.progress(seconds: 2)
        XCTAssertEqual(firedCount, 0)
    }


    func test_doesNotFireWhenDeallocated() {
        var firedCount = 0
        subject = factory.createScheduledTimer(withTimeInterval: 1, repeats: false) { firedCount += 1 }
        subject = nil
        dateProvider.progress(seconds: 2)
        XCTAssertEqual(firedCount, 0)
    }
}
