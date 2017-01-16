import XCTest

class DashboardTests: FringesTest {

    func test_titleIsCorrect() {
        tapAppIcon()
        XCTAssertEqual(dashboard.title, "Examples")
    }

    func test_rowsAreCorrectlyConfigured() {
        tapAppIcon()
        let expectedTitles = [ "Date", "Timer" ]
        XCTAssertEqual(dashboard.numberOfRows, expectedTitles.count)
        expectedTitles.enumerated().forEach {
            XCTAssertEqual(dashboard.title(forRow: $0), $1)
        }
    }

    func test_canNavigateToTheDatePage() {
        tapAppIcon()
        dashboard.tapDateRow()
        XCTAssertNotNil(date)
    }
}
