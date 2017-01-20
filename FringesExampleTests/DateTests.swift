import XCTest

class DateTests: FringesTest {

    func test_titleIsCorrect() {
        tapAppIcon()
        examples.tapDateRow()
        XCTAssertEqual(date.title, "Date")
    }

    func test_showsTheCurrentTime() {
        tapAppIcon()
        progress(seconds: 9)
        examples.tapDateRow()
        XCTAssertEqual(date.dateLabel, "21:00:09 22 August 2016")
    }
    
    func test_canExit() {
        tapAppIcon()
        examples.tapDateRow()
        XCTAssertNotNil(date)
        navigationController.tapBack()
        XCTAssertNotNil(examples)
    }

    func test_updatesTheTimeUponViewLoad() {
        tapAppIcon()
        progress(seconds: 2)
        examples.tapDateRow()
        XCTAssertEqual(date.dateLabel, "21:00:02 22 August 2016")
        navigationController.tapBack()
        progress(seconds: 1)
        examples.tapDateRow()
        XCTAssertEqual(date.dateLabel, "21:00:03 22 August 2016")
    }
}
