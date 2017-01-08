import XCTest

class SettingsTests: FringesTest {
    
    func test_canNavigateToSettings() {
        dashboard.tapOnSettingsButton()
        XCTAssertNotNil(settings)
    }
}
