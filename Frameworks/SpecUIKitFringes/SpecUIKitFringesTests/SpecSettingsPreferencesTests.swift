import XCTest
import SpecUIKitFringes

class SpecSettingsPreferencesTests: XCTestCase {

    var subject: SpecSettingsPreferences!
    var userDefaults: SpecUserDefaults!
    
    override func setUp() {
        super.setUp()
        userDefaults = SpecUserDefaults()
        subject = SpecSettingsPreferences(userDefaults: userDefaults)
    }

    func test_specifiers() {
        let specifiers = subject.specifiers
        XCTAssertEqual(specifiers, [.group,
                                    .toggleSwitch("switch_key_1")])
    }

    func test_initialSpecifierValueInUserDefaults() {
        let value = userDefaults.object(forKey: "switch_key_1")
        XCTAssertNil(value)
    }

    func test_modifyingSpecifierValueInPreferences() {
        subject.set(switch: "switch_key_1", to: true)
        let value = userDefaults.bool(forKey: "switch_key_1")
        XCTAssertTrue(value)
    }
}
