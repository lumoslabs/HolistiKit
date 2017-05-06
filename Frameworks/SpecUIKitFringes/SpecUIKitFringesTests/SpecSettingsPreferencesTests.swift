import XCTest
import SpecUIKitFringes

class SpecSettingsPreferencesTests: XCTestCase {

    var subject: SpecSettingsPreferences!
    
    override func setUp() {
        super.setUp()
        subject = SpecSettingsPreferences()
    }

    func test_parsesTheSettingsBundlePList() {
        let firstSpecifier = subject.parsedSpecifiers![0]
        let firstTitle = firstSpecifier["Title"] as! String
        XCTAssertEqual(firstTitle, "Group Title 1")
    }
}
