import XCTest

class DateTests: FringesTest {

    func test_titleIsCorrect() {
        tapAppIcon()
        dashboard.tapDateRow()
        XCTAssertEqual(date.title, "Date")
    }

    func test_showsTheCurrentTime() {
        tapAppIcon()
        progress(seconds: 9)
        dashboard.tapDateRow()
        XCTAssertEqual(date.dateLabel, "21:00:09 22 August 2016")
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
        progress(seconds: 2)
        dashboard.tapDateRow()
        XCTAssertEqual(date.dateLabel, "21:00:02 22 August 2016")
        tapBack()
        progress(seconds: 1)
        dashboard.tapDateRow()
        XCTAssertEqual(date.dateLabel, "21:00:03 22 August 2016")
    }
}
