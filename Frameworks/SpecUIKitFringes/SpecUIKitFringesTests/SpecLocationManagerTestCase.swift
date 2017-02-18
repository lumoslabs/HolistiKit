import XCTest
@testable import SpecUIKitFringes

class SpecLocationManagerTestCase: SpecUIKitFringesTestCase {

    var subject: SpecLocationManager!
    var delegate: SpecLocationManagerDelegate!
    var dialogManager: SpecDialogManager!
    
    override func setUp() {
        super.setUp()

        dialogManager = SpecDialogManager(errorHandler: errorHandler)
        subject = SpecLocationManager(dialogManager: dialogManager)
        delegate = SpecLocationManagerDelegate()
        subject.delegate = delegate
    }
}
