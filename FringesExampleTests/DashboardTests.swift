import XCTest

class DashboardTests: FringesTest {

    func test_titleIsCorrect() {
        tapAppIcon()
        XCTAssertEqual(dashboard.title, "Examples")
    }

    func test_rowsAreCorrectlyConfigured() {
        tapAppIcon()
        XCTAssertEqual(dashboard.numberOfRows, 1)
        XCTAssertEqual(dashboard.title(forRow: 0), "Settings")
    }

    func test_tappingOnTheFirstRowNavigatesToTheSettingsPage() {
        tapAppIcon()
        dashboard.tap(row: 0)
        XCTAssertNotNil(settings)
    }
}
