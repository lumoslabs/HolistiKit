import XCTest
@testable import SpecUIKitFringes

class SpecSettingsPreferencesTests: XCTestCase {

    var subject: SpecSettingsPreferences!
    var userDefaults: SpecUserDefaults!
    var errorHandler: SpecErrorHandler!
    
    override func setUp() {
        super.setUp()
        errorHandler = SpecErrorHandler()
        userDefaults = SpecUserDefaults()
        subject = SpecSettingsPreferences(errorHandler: errorHandler,
                                          userDefaults: userDefaults)
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

    func test_modifyingANonMatchingSpecifierValueInPreferences() {
        errorHandler.fatalErrorsOff {
            self.subject.set(switch: "i_dont_exist", to: true)
        }
        XCTAssertEqual(errorHandler.recordedError,
                       .noSuchPreferencesSpecifier(.toggleSwitch("i_dont_exist"),
                                                   [.group, .toggleSwitch("switch_key_1")]))
    }
}
