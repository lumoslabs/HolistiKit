import XCTest
@testable import SpecUIKitFringes

class SpecLocationManagerTestCase: XCTestCase {

    var subject: SpecLocationManager!
    var delegate: SpecLocationManagerDelegate!
    var dialogManager: SpecDialogManager!
    var realityChecker: RealityChecker!
    
    override func setUp() {
        super.setUp()

        realityChecker = RealityChecker()
        dialogManager = SpecDialogManager(realityChecker: realityChecker)
        subject = SpecLocationManager(dialogManager: dialogManager)
        delegate = SpecLocationManagerDelegate()
        subject.delegate = delegate
    }
}
