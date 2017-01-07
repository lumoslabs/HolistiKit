import XCTest

class DashboardTests: FringesTest {
    
    func test_dashboardBackgroundIsTheRightColor() {
        XCTAssertEqual(dashboard.backgroundColor, UIColor.green)
    }
}
