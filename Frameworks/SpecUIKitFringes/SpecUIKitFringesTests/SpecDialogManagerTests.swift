import XCTest
@testable import SpecUIKitFringes

class SpecDialogManagerTests: XCTestCase {

    var subject: SpecDialogManager!
    
    override func setUp() {
        super.setUp()
        subject = SpecDialogManager()
    }

    func test_addingADialog() {
        subject.addDialog(LocationManagerDialog(identifier: .requestAccessWhileInUse))
        XCTAssertEqual(subject.visibleDialog, .locationManager(.requestAccessWhileInUse))
    }

    func test_poppingADialog() {
        subject.addDialog(LocationManagerDialog(identifier: .requestAccessWhileInUse))
        XCTAssertEqual(subject.visibleDialog, .locationManager(.requestAccessWhileInUse))
        let poppedDialog = subject.popDialog()
        XCTAssertNil(subject.visibleDialog)
        XCTAssertEqual(poppedDialog, .locationManager(.requestAccessWhileInUse))
    }
    
    func test_poppingADialogWhenNoneIsPresent() {
        XCTAssertNil(subject.popDialog())
    }
}
