import XCTest

class SettingsTests: FringesTest {

    func test_showsTheCurrentTime() {
        tapAppIcon()
        dashboard.tapSettingsRow()
        XCTAssertEqual(settings.dateLabel, "21:00 22 August 2016")
    }
}
