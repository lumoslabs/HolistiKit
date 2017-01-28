import XCTest
@testable import SpecUIKitFringes

class SpecUIKitFringesTestCase: XCTestCase {

    override func tearDown() {
        super.tearDown()
        realityChecker.clearRecordedErrors()
    }

    func fatalErrorsOff(_ block: @escaping () -> Void) {
        realityChecker.fatalErrorsOff(block)
    }

    var recordedFatalErrors: [RealityChecker.FatalError] {
        return realityChecker.recordedFatalErrors
    }

    private var realityChecker: RealityChecker {
        return RealityChecker.shared
    }
}
