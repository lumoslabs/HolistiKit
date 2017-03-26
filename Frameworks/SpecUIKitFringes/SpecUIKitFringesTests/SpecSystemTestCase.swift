import XCTest
@testable import SpecUIKitFringes

class SpecSystemTestCase: XCTestCase {

    var subject: SpecSystem!
    var recorder: Recorder!
    var errorHandler: SpecErrorHandler!
    
    override func setUp() {
        super.setUp()
        errorHandler = SpecErrorHandler()
        recorder = Recorder()
        subject = RecordingSpecSystem(recorder: recorder, errorHandler: errorHandler)
    }
}
