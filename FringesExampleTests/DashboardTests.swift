import XCTest

class DashboardTests: FringesTest {

    func test_titleIsCorrect() {
        tapAppIcon()
        XCTAssertEqual(dashboard.title, "Examples")
    }

    func test_rowsAreCorrectlyConfigured() {
        tapAppIcon()
        XCTAssertEqual(dashboard.firstRowTitle, "Settings")
    }

    func test_tappingOnTheFirstRowNavigatesToTheSettingsPage() {
        tapAppIcon()
        dashboard.tapFirstRow()
        XCTAssertNotNil(settings)
    }
}
