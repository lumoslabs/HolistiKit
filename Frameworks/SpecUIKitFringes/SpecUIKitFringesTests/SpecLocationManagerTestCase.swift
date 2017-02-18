import XCTest
@testable import SpecUIKitFringes

class SpecLocationManagerTestCase: XCTestCase {

    var subject: SpecLocationManager!
    var delegate: SpecLocationManagerDelegate!
    var systemDialog: SystemDialog!
    
    override func setUp() {
        super.setUp()

        systemDialog = SystemDialog()
        subject = SpecLocationManager(systemDialog: systemDialog)
        delegate = SpecLocationManagerDelegate()
        subject.delegate = delegate
    }
}
