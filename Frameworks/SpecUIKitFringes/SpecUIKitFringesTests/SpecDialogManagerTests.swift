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
        XCTAssertEqual(poppedDialog?.identifier, .locationManager(.requestAccessWhileInUse))
    }
    
    func test_poppingADialogWhenNoneIsPresent() {
        XCTAssertNil(subject.popDialog())
    }

    func test_tappingOnAButton() {
        let testDialog = TestDialog()
        subject.addDialog(testDialog)
        subject.tap(.allow)
        XCTAssertEqual(testDialog.response, .allow)
        XCTAssertNil(subject.visibleDialog)
    }
}

public class TestDialog: SpecDialog {

    var response: SpecDialogManager.Response?
    public let identifier: SpecDialogManager.DialogIdentifier = .locationManager(.requestAccessAlways)

    public func responded(with response: SpecDialogManager.Response) {
        self.response = response
    }
}
