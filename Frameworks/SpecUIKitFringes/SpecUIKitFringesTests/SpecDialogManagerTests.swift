import XCTest
@testable import SpecUIKitFringes

class SpecDialogManagerTests: XCTestCase {

    var subject: SpecDialogManager!
    var realityChecker: RealityChecker!
    
    override func setUp() {
        super.setUp()
        realityChecker = RealityChecker()
        subject = SpecDialogManager(realityChecker: realityChecker)
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

    func test_tappingOnANonExistentButton() {
        let testDialog = TestDialog()
        subject.addDialog(testDialog)
        realityChecker.fatalErrorsOff {
            self.subject.tap(.dontAllow)
        }
        XCTAssertEqual(realityChecker.recordedFatalErrors, [.notAValidDialogResponse])
    }
}

public class TestDialog: SpecDialog {

    var response: SpecDialogManager.Response?
    public let identifier: SpecDialogManager.DialogIdentifier = .locationManager(.requestAccessAlways)
    private let acceptableResponses: [SpecDialogManager.Response]

    init(acceptableResponses: [SpecDialogManager.Response] = [.allow]) {
        self.acceptableResponses = acceptableResponses
    }

    public func responded(with response: SpecDialogManager.Response) -> Bool {
        if !acceptableResponses.contains(response) { return false }
        self.response = response
        return true
    }
}
