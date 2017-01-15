import XCTest

class SettingsTests: FringesTest {

    func test_showsTheCurrentTime() {
        tapAppIcon()
        progress(minutes: 1)
        dashboard.tapSettingsRow()
        XCTAssertEqual(settings.dateLabel, "21:01 22 August 2016")
    }
}
