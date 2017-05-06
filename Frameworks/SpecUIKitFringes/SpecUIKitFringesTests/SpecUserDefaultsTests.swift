import XCTest
import SpecUIKitFringes

class SpecUserDefaultsTests: XCTestCase {

    var subject: SpecUserDefaults!
    var recorder: Recorder!
    var notificationCenter: NotificationCenter!
    var tokens: [NSObjectProtocol]!

    override func setUp() {
        super.setUp()
        
        notificationCenter = NotificationCenter.default
        recorder = Recorder()
        subject = SpecUserDefaults()

        tokens = [NSObjectProtocol]()
        [UserDefaults.didChangeNotification].forEach(addNotification)
    }

    override func tearDown() {
        super.tearDown()
        tokens.forEach(notificationCenter.removeObserver)
    }

    private func addNotification(for notificationName: NSNotification.Name) {
        let token = notificationCenter.addObserver(
            forName: notificationName,
            object: nil,
            queue: nil) { [weak self] _ in
                self?.recorder.record(.notification(notificationName))
        }
        tokens.append(token)
    }

    // set

    func test_changeNotification() {
        subject.set("bar", forKey: "foo")
        XCTAssertEqual(recorder.events, [.notification(UserDefaults.didChangeNotification)])
    }

    // object

    func test_objectForKeyWhenNotNil() {
        subject.set("bar", forKey: "foo")
        let value = subject.object(forKey: "foo") as! String
        XCTAssertEqual(value, "bar")
    }

    func test_objectForKeyWhenNil() {
        let value = subject.object(forKey: "foo")
        XCTAssertNil(value)
    }

    // integer

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

    // boolean

    func test_boolForKeyWhenATrueBoolean() {
        subject.set(true, forKey: "foo")
        let value = subject.bool(forKey: "foo")
        XCTAssertTrue(value)
    }

    func test_boolForKeyWhenAFalseBoolean() {
        subject.set(false, forKey: "foo")
        let value = subject.bool(forKey: "foo")
        XCTAssertFalse(value)
    }

    func test_boolForKeyWhenNil() {
        let value = subject.bool(forKey: "foo")
        XCTAssertFalse(value)
    }

    func test_boolForKeyWhenATrueString() {
        subject.set("true", forKey: "foo")
        let value = subject.bool(forKey: "foo")
        XCTAssertTrue(value)
    }

    func test_boolForKeyWhenAYesString() {
        subject.set("YES", forKey: "foo")
        let value = subject.bool(forKey: "foo")
        XCTAssertTrue(value)
    }

    func test_boolForKeyWhenAFalseString() {
        subject.set("false", forKey: "foo")
        let value = subject.bool(forKey: "foo")
        XCTAssertFalse(value)
    }

    func test_boolForKeyWhenANoString() {
        subject.set("NO", forKey: "foo")
        let value = subject.bool(forKey: "foo")
        XCTAssertFalse(value)
    }

    func test_boolForKeyWhenZeroInteger() {
        subject.set(0, forKey: "foo")
        let value = subject.bool(forKey: "foo")
        XCTAssertFalse(value)
    }

    func test_boolForKeyWhenNonZeroInteger() {
        subject.set(1, forKey: "foo")
        let value = subject.bool(forKey: "foo")
        XCTAssertTrue(value)
    }

    func test_boolForKeyWhenNotConvertable() {
        subject.set("bar", forKey: "foo")
        let value = subject.bool(forKey: "foo")
        XCTAssertFalse(value)
    }
}
