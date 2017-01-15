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
        XCTAssertEqual(date.dateLabel, "21:01:00 22 August 2016")
    }
    
    func test_canExit() {
        tapAppIcon()
        dashboard.tapDateRow()
        XCTAssertNotNil(date)
        tapBack()
        XCTAssertNotNil(dashboard)
    }

    func test_updatesTheTimeUponViewLoad() {
        tapAppIcon()
        progress(seconds: 2, hours: 4)
        dashboard.tapDateRow()
        XCTAssertEqual(date.dateLabel, "01:00:02 23 August 2016")
        tapBack()
        progress(minutes: 2, days: 1)
        dashboard.tapDateRow()
        XCTAssertEqual(date.dateLabel, "01:02:02 24 August 2016")
    }
}
