import XCTest
@testable import SpecUIKitFringes

class SpecLocationManagerTestCase: XCTestCase {

    var subject: SpecLocationManager!
    var delegate: SpecLocationManagerDelegate!
    var dialogManager: SpecDialogManager!
    
    override func setUp() {
        super.setUp()

        dialogManager = SpecDialogManager()
        subject = SpecLocationManager(dialogManager: dialogManager)
        delegate = SpecLocationManagerDelegate()
        subject.delegate = delegate
    }
}
