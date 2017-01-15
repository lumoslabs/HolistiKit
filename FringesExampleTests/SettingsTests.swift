import XCTest

class SettingsTests: FringesTest {

    func test_showsTheCurrentTime() {
        tapAppIcon()
        dashboard.tapSettingsRow()
        XCTAssertEqual(settings.dateLabel, "00:00 August 23rd, 2016")
    }
}
