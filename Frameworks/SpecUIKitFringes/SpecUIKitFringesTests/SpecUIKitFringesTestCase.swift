import XCTest
@testable import SpecUIKitFringes

class SpecUIKitFringesTestCase: XCTestCase {

    var realityChecker: RealityChecker!

    override func setUp() {
        super.setUp()
        realityChecker = RealityChecker()
    }

    func fatalErrorsOff(_ block: @escaping () -> Void) {
        realityChecker.fatalErrorsOff(block)
    }

    var recordedFatalErrors: [RealityChecker.FatalError] {
        return realityChecker.recordedFatalErrors
    }
}
