import XCTest
import CoreLocation
@testable import SpecUIKitFringes

class LocationUpdatingTests: SpecLocationManagerTestCase {

    func test_locationRequestSuccess_AfterRequestLocation() {
        subject.setAuthorizationStatusInSettingsApp(.authorizedWhenInUse)
        subject.requestLocation()
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 0)
        
        subject.locationRequestSuccess()
        
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 1)
        
        errorHandler.fatalErrorsOff {
            self.subject.locationRequestSuccess()
        }
        XCTAssertEqual(errorHandler.recordedError, .noLocationRequestInProgress)
    }

    func test_requestLocation_WhileNotDetermined() {
        XCTAssertEqual(subject.authorizationStatus(), .notDetermined)
        XCTAssertNil(delegate.receivedError)

        subject.requestLocation()

        XCTAssertNotNil(delegate.receivedError)
    }

    func test_locationRequestSuccess_AfterStartUpdatingLocation() {
        subject.setAuthorizationStatusInSettingsApp(.authorizedWhenInUse)
        subject.startUpdatingLocation()
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 0)
        
        subject.locationRequestSuccess()
        
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 1)
        
        subject.locationRequestSuccess()
        
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 2)
    }

    func test_startUpdatingLocation_WhileNotDetermined() {
        XCTAssertEqual(subject.authorizationStatus(), .notDetermined)
        XCTAssertNil(delegate.receivedError)

        subject.startUpdatingLocation()

        XCTAssertNil(delegate.receivedError)
    }

    func test_location_BeforeHavingEverReceivedALocation() {
        XCTAssertNil(subject.location)
    }

    func test_location_AfterHavingReceivedALocationBefore() {
        subject.setAuthorizationStatusInSettingsApp(.authorizedWhenInUse)
        subject.requestLocation()
        subject.locationRequestSuccess()
        
        XCTAssertNotNil(subject.location)
    }

    func test_updatedLocationWithoutAuthorization() {
        errorHandler.fatalErrorsOff {
            self.subject.locationRequestSuccess()
        }
        XCTAssertEqual(errorHandler.recordedError, .notAuthorized)
    }
}
