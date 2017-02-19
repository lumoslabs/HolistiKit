import XCTest
import CoreLocation
@testable import UIKitFringes

class CLLocationManagerTests: XCTestCase {

    var originalManager: StubbedCLLocationManager!
    var subject: LocationManager!
    var delegate: RecordingLocationManagingDelegate!
    
    override func setUp() {
        super.setUp()

        self.originalManager = StubbedCLLocationManager()
        self.subject = LocationManager(clLocationManager: originalManager)
        self.delegate = RecordingLocationManagingDelegate()
        subject.delegate = delegate
    }

    func test_location() {
        let location = CLLocation(latitude: 1.0, longitude: 2.0)
        originalManager._location = location
        XCTAssertEqual(subject.location, location)
    }

    func test_authorizationStatus() {
        StubbedCLLocationManager._authorizationStatus = .authorizedAlways
        XCTAssertEqual(subject.authorizationStatus(), .authorizedAlways)
    }

    func test_delegate_didUpdateLocations() {
        let location = CLLocation(latitude: 66.0, longitude: 77.0)
        originalManager.delegate?.locationManager?(originalManager, didUpdateLocations: [location])
        XCTAssertEqual(delegate.updatedLocations, [location])
    }
}

class StubbedCLLocationManager: CLLocationManager {

    var _location: CLLocation?
    override var location: CLLocation? { return _location }

    static var _authorizationStatus: CLAuthorizationStatus = .notDetermined
    override static func authorizationStatus() -> CLAuthorizationStatus { return _authorizationStatus }
}

class RecordingLocationManagingDelegate: LocationManagingDelegate {

    var updatedLocations = [CLLocation]()

    func locationManager(didUpdateLocations locations: [CLLocation]) {
        updatedLocations.append(contentsOf: locations)
    }
}
