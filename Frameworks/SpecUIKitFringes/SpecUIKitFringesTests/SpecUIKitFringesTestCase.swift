import XCTest
@testable import SpecUIKitFringes

class SpecUIKitFringesTestCase: XCTestCase {

    var errorHandler: SpecErrorHandler!

    override func setUp() {
        super.setUp()
        errorHandler = SpecErrorHandler()
    }

    func fatalErrorsOff(_ block: @escaping () -> Void) {
        errorHandler.fatalErrorsOff(block)
    }

    var recordedFatalErrors: [SpecErrorHandler.FatalError] {
        return errorHandler.recordedFatalErrors
    }
}
