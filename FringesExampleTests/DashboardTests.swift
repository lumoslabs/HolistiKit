import XCTest

class DashboardTests: FringesTest {

    func test_rowsAreCorrectlyConfigured() {
        XCTAssertEqual(dashboard.firstRowTitle, "Settings")
    }

    func test_tappingOnTheFirstRowNavigatesToTheSettingsPage() {
        dashboard.tapFirstRow()
        XCTAssertNotNil(settings)
    }
}
