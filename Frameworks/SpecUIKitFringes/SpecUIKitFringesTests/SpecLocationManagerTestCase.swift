import XCTest
@testable import SpecUIKitFringes

class SpecLocationManagerTestCase: XCTestCase {

    var subject: SpecLocationManager!
    var delegate: SpecLocationManagerDelegate!
    
    override func setUp() {
        super.setUp()

        subject = SpecLocationManager()
        delegate = SpecLocationManagerDelegate()
        subject.delegate = delegate
    }
}
