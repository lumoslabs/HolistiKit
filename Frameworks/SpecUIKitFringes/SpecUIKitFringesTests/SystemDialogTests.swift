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

    func test_poppingADialog() {
        subject.addDialog(withIdentifier: .locationManager(.requestAccessWhileInUse))
        XCTAssertEqual(subject.visibleDialog, .locationManager(.requestAccessWhileInUse))
        let poppeDialog = subject.popDialog()
        XCTAssertNil(subject.visibleDialog)
        XCTAssertEqual(poppeDialog, .locationManager(.requestAccessWhileInUse))
    }
    
    func test_poppingADialogWhenNoneIsPresent() {
        XCTAssertNil(subject.popDialog())
    }
}
