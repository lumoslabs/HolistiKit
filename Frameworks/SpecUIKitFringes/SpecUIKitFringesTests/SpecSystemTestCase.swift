import XCTest
@testable import SpecUIKitFringes

class SpecSystemTestCase: SpecUIKitFringesTestCase {

    var subject: SpecSystem!
    
    override func setUp() {
        super.setUp()
        subject = RecordingSpecSystem()
    }

    var appDelegate: RecordingSpecApplicationDelegate! {
        return subject.appDelegate as? RecordingSpecApplicationDelegate
    }
}
