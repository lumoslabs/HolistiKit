import XCTest
import SpecUIKitFringes

class SpecUserDefaultsTests: XCTestCase {

    var subject: SpecUserDefaults!

    override func setUp() {
        super.setUp()
        subject = SpecUserDefaults()
    }

    func test_objectForKeyWhenNotNil() {
        subject.set("bar", forKey: "foo")
        let value = subject.object(forKey: "foo") as! String
        XCTAssertEqual(value, "bar")
    }

    func test_objectForKeyWhenNil() {
        let value = subject.object(forKey: "foo")
        XCTAssertNil(value)
    }

    func test_integerForKeyWhenAnInteger() {
        subject.set(42, forKey: "foo")
        let value = subject.integer(forKey: "foo")
        XCTAssertEqual(value, 42)
    }

    func test_integerForKeyWhenNil() {
        let value = subject.integer(forKey: "foo")
        XCTAssertEqual(value, 0)
    }

    func test_integerForKeyWhenConvertable() {
        subject.set("666", forKey: "foo")
        let value = subject.integer(forKey: "foo")
        XCTAssertEqual(value, 666)
    }

    func test_integerForKeyWhenNotConvertable() {
        subject.set("bar", forKey: "foo")
        let value = subject.integer(forKey: "foo")
        XCTAssertEqual(value, 0)
    }

    func test_integerForKeyWhenBooleanFalse() {
        subject.set(false, forKey: "foo")
        let value = subject.integer(forKey: "foo")
        XCTAssertEqual(value, 0)
    }

    func test_integerForKeyWhenBooleanTrue() {
        subject.set(true, forKey: "foo")
        let value = subject.integer(forKey: "foo")
        XCTAssertEqual(value, 1)
    }
}
