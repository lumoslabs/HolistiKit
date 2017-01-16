import XCTest

class TimerTests: FringesTest {

    func test_titleIsCorrect() {
        tapAppIcon()
        dashboard.tapTimerRow()
        XCTAssertEqual(timer.title, "Timer")
    }
}
