import XCTest

class DashboardTests: FringesTest {

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
