import XCTest
@testable import SpecUIKitFringes

class MultipleLocationManagersTests: SpecLocationManagerTestCase {

    var subject2: SpecLocationManager!
    var delegate2: SpecLocationManagerDelegate!

    override func setUp() {
        super.setUp()
        
        subject2 = factory.create()
        delegate2 = SpecLocationManagerDelegate()
        subject2.delegate = delegate2
    }

    func test_authorizationStatusIsShared() {
        subject.requestWhenInUseAuthorization()
        dialogManager.tap(.allow)
        
        XCTAssertEqual(subject.authorizationStatus(), .authorizedWhenInUse)
        XCTAssertEqual(subject2.authorizationStatus(), .authorizedWhenInUse)
        XCTAssertEqual(delegate.receivedAuthorizationChange, .authorizedWhenInUse)
        XCTAssertEqual(delegate2.receivedAuthorizationChange, .authorizedWhenInUse)
    }

    func test_locationServicesEnabledStatusIsShared() {
        subject.requestWhenInUseAuthorization()
        dialogManager.tap(.allow)

        subject.setLocationServicesEnabledInSettingsApp(false)
        
        XCTAssertEqual(subject.authorizationStatus(), .denied)
        XCTAssertEqual(subject2.authorizationStatus(), .denied)
        XCTAssertEqual(delegate.receivedAuthorizationChange, .denied)
        XCTAssertEqual(delegate2.receivedAuthorizationChange, .denied)
    }
}
