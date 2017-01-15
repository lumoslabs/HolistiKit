import XCTest

class DashboardTests: FringesTest {

    func test_titleIsCorrect() {
        tapAppIcon()
        XCTAssertEqual(dashboard.title, "Examples")
    }

    func test_rowsAreCorrectlyConfigured() {
        tapAppIcon()
        let expectedTitles = [ "Settings" ]
        XCTAssertEqual(dashboard.numberOfRows, expectedTitles.count)
        expectedTitles.enumerated().forEach {
            XCTAssertEqual(dashboard.title(forRow: $0), $1)
        }
    }

    func test_canNavigateToTheSettingsPage() {
        tapAppIcon()
        dashboard.tap(row: 0)
        XCTAssertNotNil(settings)
    }
}
