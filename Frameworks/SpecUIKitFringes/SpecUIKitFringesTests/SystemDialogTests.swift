import XCTest
@testable import SpecUIKitFringes

class SystemDialogTests: XCTestCase {

    var subject: SystemDialog!
    
    override func setUp() {
        super.setUp()
        subject = SystemDialog()
    }

    func test_addingADialog() {
        subject.addDialog(withIdentifier: .locationManager(.requestAccessWhileInUse))
        XCTAssertEqual(subject.visibleDialog, .locationManager(.requestAccessWhileInUse))
    }
}
