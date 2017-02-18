import XCTest
@testable import SpecUIKitFringes

class SystemDialogTests: XCTestCase {

    var subject: SystemDialog!
    
    override func setUp() {
        super.setUp()
        subject = SystemDialog()
    }

    func test_addingADialog() {
        subject.addDialog(withIdentifier: LocationManagerDialog(identifier: .requestAccessWhileInUse))
        XCTAssertEqual(subject.visibleDialog, .locationManager(.requestAccessWhileInUse))
    }

    func test_poppingADialog() {
        subject.addDialog(withIdentifier: LocationManagerDialog(identifier: .requestAccessWhileInUse))
        XCTAssertEqual(subject.visibleDialog, .locationManager(.requestAccessWhileInUse))
        let poppedDialog = subject.popDialog()
        XCTAssertNil(subject.visibleDialog)
        XCTAssertEqual(poppedDialog, .locationManager(.requestAccessWhileInUse))
    }
    
    func test_poppingADialogWhenNoneIsPresent() {
        XCTAssertNil(subject.popDialog())
    }
}
