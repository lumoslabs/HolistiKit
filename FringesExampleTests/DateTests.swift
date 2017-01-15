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
    
    func test_canExit() {
        tapAppIcon()
        dashboard.tapDateRow()
        XCTAssertNotNil(date)
        tapBack()
        XCTAssertNotNil(dashboard)
    }

    func test_updatesTheTimeUponViewLoad() {
        tapAppIcon()
        progress(minutes: 5)
        dashboard.tapDateRow()
        XCTAssertEqual(date.dateLabel, "21:05 22 August 2016")
        tapBack()
        progress(minutes: 2)
        dashboard.tapDateRow()
        XCTAssertEqual(date.dateLabel, "21:07 22 August 2016")
    }
}
