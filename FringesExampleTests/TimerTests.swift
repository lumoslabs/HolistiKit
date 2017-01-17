import XCTest

class TimerTests: FringesTest {

    func test_titleIsCorrect() {
        tapAppIcon()
        examples.tapTimerRow()
        XCTAssertEqual(timer.title, "Timer")
    }

    func test_testLabelUpdatesAsTimePasses() {
        tapAppIcon()
        examples.tapTimerRow()
        XCTAssertEqual(timer.dateLabel, "21:00:00 22 August 2016")
        progress(seconds: 2)
        XCTAssertEqual(timer.dateLabel, "21:00:02 22 August 2016")
        progress(seconds: 3)
        XCTAssertEqual(timer.dateLabel, "21:00:05 22 August 2016")
    }
}
