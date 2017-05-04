import XCTest
import UIKitFringes
import SpecUIKitFringes

class SpecScheduledTimerTests: XCTestCase {

    var subject: Timing!
    var dateProvider: SpecDateProvider!
    
    override func setUp() {
        super.setUp()
        dateProvider = SpecDateProvider()
        let factory = SpecTimerFactory(dateProvider: dateProvider)
        subject = factory.create()
    }

    func test_firesAtAnInterval() {
        var firedCount = 0
        dateProvider.progress(seconds: 1)
        subject.start(interval: 2, repeats: true) { firedCount += 1 }
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
        subject.start(interval: 2, repeats: true) { firedCount += 1 }
        XCTAssertEqual(firedCount, 0)
        dateProvider.progress(seconds: 4)
        XCTAssertEqual(firedCount, 2)
    }

    func test_doesNotRepeatIfConfiguredNotTo() {
        var firedCount = 0
        subject.start(interval: 2, repeats: false) { firedCount += 1 }
        dateProvider.progress(seconds: 2)
        XCTAssertEqual(firedCount, 1)
        dateProvider.progress(seconds: 2)
        XCTAssertEqual(firedCount, 1)
    }

    func test_doesNotFireIfInvalidated() {
        var firedCount = 0
        subject.start(interval: 2, repeats: false) { firedCount += 1 }
        subject.invalidate()
        dateProvider.progress(seconds: 2)
        XCTAssertEqual(firedCount, 0)
    }
}
