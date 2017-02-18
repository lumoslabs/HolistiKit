import XCTest
@testable import SpecUIKitFringes

class SpecLocationManagerTestCase: XCTestCase {

    var subject: SpecLocationManager!
    var delegate: SpecLocationManagerDelegate!
    var dialogManager: SpecDialogManager!
    var errorHandler: SpecErrorHandler!
    
    override func setUp() {
        super.setUp()

        errorHandler = SpecErrorHandler()
        dialogManager = SpecDialogManager(errorHandler: errorHandler)
        subject = SpecLocationManager(dialogManager: dialogManager,
                                      errorHandler: errorHandler)
        delegate = SpecLocationManagerDelegate()
        subject.delegate = delegate
    }
}
