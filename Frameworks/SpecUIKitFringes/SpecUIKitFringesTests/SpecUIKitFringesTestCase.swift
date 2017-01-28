import XCTest
@testable import SpecUIKitFringes

class SpecUIKitFringesTestCase: XCTestCase {

    func fatalErrorsOff(_ block: @escaping () -> Void) {
        realityChecker.fatalErrorsOff(block)
    }

    var recordedFatalError: RealityChecker.FatalError? {
        return realityChecker.recordedFatalError
    }

    private var realityChecker: RealityChecker {
        return RealityChecker.shared
    }
}
