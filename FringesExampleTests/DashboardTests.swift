import XCTest

class DashboardTests: FringesTest {
    
    func test_dashboardBackgroundIsTheRightColor() {
        XCTAssertEqual(dashboard.backgroundColor, UIColor.green)
    }

    func test_tappingOnAddToCountButtonChangesTheLabel() {
        XCTAssertEqual(dashboard.countLabel, "Never tapped before")
        dashboard.tapOnAddToCountButton()
        XCTAssertEqual(dashboard.countLabel, "tapped 1 time")
        dashboard.tapOnAddToCountButton()
        XCTAssertEqual(dashboard.countLabel, "tapped 2 times")
    }
}
