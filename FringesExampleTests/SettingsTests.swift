import XCTest

class SettingsTests: FringesTest {

    var settings: SpecSettingsViewControllerUI? {
        return dashboard.presentedViewController as? SpecSettingsViewControllerUI
    }
    
    func test_canNavigateToSettings() {
        dashboard.tapOnSettingsButton()
        XCTAssertNotNil(settings)
    }
}
