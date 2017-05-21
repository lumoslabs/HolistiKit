import XCTest
import SpecUIKitFringes

class SpecLocaleProviderTests: XCTestCase {

    var subject: SpecLocaleProvider!
    
    override func setUp() {
        super.setUp()
        subject = SpecLocaleProvider()
    }

    func test_initialLocale() {
        let expected = Locale(identifier: "ha_GH")
        let actual = subject.current
        XCTAssertEqual(expected, actual)
    }

    func test_settingLocale() {
        let expected = Locale(identifier: "ar_MR")
        subject.set(locale: expected)
        let actual = subject.current
        XCTAssertEqual(expected, actual)
    }
}
