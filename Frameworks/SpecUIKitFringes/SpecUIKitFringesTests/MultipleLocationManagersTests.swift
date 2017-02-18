import XCTest
@testable import SpecUIKitFringes

class MultipleLocationManagersTests: SpecLocationManagerTestCase {

    func test_authorizationStatusIsShared() {
        let subject2 = factory.create()
        let delegate2 = SpecLocationManagerDelegate()
        subject2.delegate = delegate2
        
        subject.requestWhenInUseAuthorization()
        dialogManager.tap(.allow)
        
        XCTAssertEqual(subject.authorizationStatus(), .authorizedWhenInUse)
        XCTAssertEqual(subject2.authorizationStatus(), .authorizedWhenInUse)
        XCTAssertEqual(delegate.receivedAuthorizationChange, .authorizedWhenInUse)
        XCTAssertEqual(delegate2.receivedAuthorizationChange, .authorizedWhenInUse)
    }
}
