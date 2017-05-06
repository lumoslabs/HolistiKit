import XCTest
import SpecUIKitFringes

class SpecSettingsPreferencesTests: XCTestCase {

    var subject: SpecSettingsPreferences!
    
    override func setUp() {
        super.setUp()
        subject = SpecSettingsPreferences()
    }

    func test_specifiers() {
        let specifiers = subject.specifiers
        XCTAssertEqual(specifiers, [.group,
                                    .toggleSwitch("switch_key_1")])
    }
}
