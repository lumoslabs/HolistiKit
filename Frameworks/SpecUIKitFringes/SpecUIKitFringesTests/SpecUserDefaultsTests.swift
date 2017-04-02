import XCTest
import SpecUIKitFringes

class SpecUserDefaultsTests: XCTestCase {

    var subject: SpecUserDefaults!

    override func setUp() {
        super.setUp()
        subject = SpecUserDefaults()
    }

    func test_objectForKeyWhenNil() {
        let value = subject.object(forKey: "foo")
        XCTAssertNil(value)
    }

    func test_objectForKeyWhenNotNil() {
        subject.set("bar", forKey: "foo")
        let value = subject.object(forKey: "foo") as! String
        XCTAssertEqual(value, "bar")
    }
}
