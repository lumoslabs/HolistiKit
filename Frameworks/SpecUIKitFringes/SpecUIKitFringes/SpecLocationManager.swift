import CoreLocation
import UIKitFringes

/*
 This class is used in place of CLLocationManager while in specs.
 It conforms to a subset of the same interface via LocationManaging.
 This allows us to test code which relies on state and behavior 
 which is not under our control in CLLocationManager. Things like 
 setting authorization status, setting current location, and responding
 to dialog prompts. It also allows us to document and test against 
 our assumptions about how CLLocationManager works (based on 
 documentation and experimenting with it).
*/

/* TODO
 * Interact with a SpecUserLocation class which will send new coordinates to this class instead
 * Add a check for the necessary string before showing an auth dialog: Bundle.main.infoDictionary?["NSLocationWhenInUseUsageDescription"]
 */

public class SpecLocationManager {

    public weak var delegate: CLLocationManagerDelegate?
    public var location: CLLocation? { return userLocation.location }

    fileprivate let userLocation: SpecUserLocation
    fileprivate let dialogManager: SpecDialogManager
    fileprivate let errorHandler: SpecErrorHandler
    fileprivate let locationServices: SpecLocationServices
    fileprivate let locationAuthorizationStatus: SpecLocationAuthorizationStatus
    fileprivate let bsFirstArg = CLLocationManager()
    fileprivate var locationRequestInProgress = false
    fileprivate var updatingLocation = false

    public convenience init(dialogManager: SpecDialogManager,
                            userLocation: SpecUserLocation,
                            locationServices: SpecLocationServices,
                            locationAuthorizationStatus: SpecLocationAuthorizationStatus) {
        let errorHandler = SpecErrorHandler()
        self.init(dialogManager: dialogManager,
                  errorHandler: errorHandler,
                  userLocation: userLocation,
                  locationServices: locationServices,
                  locationAuthorizationStatus: locationAuthorizationStatus)
    }

    init(dialogManager: SpecDialogManager,
         errorHandler: SpecErrorHandler,
         userLocation: SpecUserLocation,
         locationServices: SpecLocationServices,
         locationAuthorizationStatus: SpecLocationAuthorizationStatus) {
        self.dialogManager = dialogManager
        self.userLocation = userLocation
        self.errorHandler = errorHandler
        self.locationServices = locationServices
        self.locationAuthorizationStatus = locationAuthorizationStatus
        userLocation.observe(on: self, selector: #selector(didChangeLocation))
        locationServices.observe(on: self, selector: #selector(locationServicesEnabledDidChange))
        locationAuthorizationStatus.observe(on: self, selector: #selector(didChangeAuthorizationStatus))
    }

    @objc
    func didChangeLocation() {
        delegate!.locationManager?(bsFirstArg, didUpdateLocations: [userLocation.location!])
    }

    @objc
    func didChangeAuthorizationStatus() {
        sendCurrentStatus()
    }

    @objc
    func locationServicesEnabledDidChange() {
        sendCurrentStatus()
    }

    fileprivate func sendCurrentStatus() {
        delegate?.locationManager?(bsFirstArg, didChangeAuthorization: authorizationStatus())
    }
}

// MARK: Async callbacks
extension SpecLocationManager {

    public func locationRequestSuccess() {
        if ![.authorizedWhenInUse, .authorizedAlways].contains(authorizationStatus()) {
            errorHandler.error(.notAuthorized)
        }
        if !(locationRequestInProgress || updatingLocation) {
            errorHandler.error(.noLocationRequestInProgress)
        }
        locationRequestInProgress = false
        let fakeCurrentLocation = CLLocation(latitude: 1.0, longitude: 2.0)
        userLocation.location = fakeCurrentLocation
    }

}

// MARK: User taps for authorization dialog prompts
extension SpecLocationManager {

    public func respondedTo(dialog: SpecDialogManager.LocationManagerIdentifier,
                            with response: SpecDialogManager.Response) -> Bool {
        switch dialog {
        case .requestAccessWhileInUse:
            switch response {
            case .allow: locationAuthorizationStatus.authorizationStatus = .authorizedWhenInUse
            case .dontAllow: locationAuthorizationStatus.authorizationStatus = .denied
            default: return false
            }
        case .requestAccessAlways:
            switch response {
            case .allow: locationAuthorizationStatus.authorizationStatus = .authorizedAlways
            case .dontAllow: locationAuthorizationStatus.authorizationStatus = .denied
            default: return false
            }
        case .requestJumpToLocationServicesSettings:
            switch response {
            case .settings, .cancel: tapSettingsOrCancelInDialog()
            default: return false
            }
        }
        return true
    }

    private func tapSettingsOrCancelInDialog() {
        locationServices.respondedToLocationServicesDialog()
    }
}

// MARK: LocationManaging
extension SpecLocationManager: LocationManaging {

    public func requestWhenInUseAuthorization() {
        switch authorizationStatus() {
        case .notDetermined: requestWhenInUseWhileNotDetermined()
        case .denied:
            // if .denied due to base status (the user having tapped "Don't Allow" before)
            if locationAuthorizationStatus.authorizationStatus == .denied { break }
            if !isLocationServicesEnabled() {
                // or, if .denied due to Location Services being off, but user has not before denied auth.
                requestWhenInUseWhileDeniedDueToLocationServices()
            } else {
                fatalError("How is auth status .denied if not due to base status being .denied or Location Services being off?")
            }
        case .authorizedWhenInUse: break
        default: fatalError("Other authorization statuses are not supported yet.")
        }
    }

    public func requestLocation() {
        switch authorizationStatus() {
        case .notDetermined: requestLocationWhileNotDetermined()
        case .authorizedWhenInUse: requestLocationWhileWhenInUse()
        default: fatalError("Other authorization statuses are not supported yet.")
        }
    }

    public func startUpdatingLocation() {
        switch authorizationStatus() {
        case .notDetermined: break
        case .authorizedWhenInUse: startUpdatingLocationWhileWhenInUse()
        default: fatalError("Other authorization statuses are not supported yet.")
        }
    }
    
    public func authorizationStatus() -> CLAuthorizationStatus {
        if !isLocationServicesEnabled() { return .denied }
        return locationAuthorizationStatus.authorizationStatus
    }

    public func isLocationServicesEnabled() -> Bool {
        return locationServices.enabled
    }

    private func requestWhenInUseWhileNotDetermined() {
        dialogManager.addDialog(LocationManagerDialog(identifier: .requestAccessWhileInUse, locationManager: self))
    }

    private func requestWhenInUseWhileDeniedDueToLocationServices() {
        if !locationServices.canShowDialog { return }
        dialogManager.addDialog(LocationManagerDialog(identifier: .requestJumpToLocationServicesSettings, locationManager: self))
    }

    private func startUpdatingLocationWhileWhenInUse() {
        updatingLocation = true
    }

    private func requestLocationWhileNotDetermined() {
        let error = NSError(domain: kCLErrorDomain, code: 0, userInfo: nil)
        // this actually happens about 10 seconds later
        delegate!.locationManager!(bsFirstArg, didFailWithError: error)
    }

    private func requestLocationWhileWhenInUse() {
        locationRequestInProgress = true
    }
}
