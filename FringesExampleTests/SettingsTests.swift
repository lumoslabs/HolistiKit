import XCTest

class DateTests: FringesTest {

    func test_titleIsCorrect() {
        tapAppIcon()
        dashboard.tapDateRow()
        XCTAssertEqual(date.title, "Date")
    }

    func test_showsTheCurrentTime() {
        tapAppIcon()
        progress(minutes: 1)
        dashboard.tapDateRow()
        XCTAssertEqual(date.dateLabel, "21:01 22 August 2016")
    }
}
