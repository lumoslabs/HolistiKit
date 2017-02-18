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
 * Instantiate SpecLocationManagers on the fly via an injected factory and update them via a broadcast from a system-level user location object
 * Add a check for the necessary string before showing an auth dialog: Bundle.main.infoDictionary?["NSLocationWhenInUseUsageDescription"]
 */

public class SpecLocationManager {

    fileprivate let dialogManager: SpecDialogManager
    fileprivate let errorHandler: SpecErrorHandler
    fileprivate let locationServices: SpecLocationServices
    fileprivate let locationAuthorizationStatus: SpecLocationAuthorizationStatus

    public convenience init(dialogManager: SpecDialogManager,
                            locationServices: SpecLocationServices,
                            locationAuthorizationStatus: SpecLocationAuthorizationStatus) {
        let errorHandler = SpecErrorHandler()
        self.init(dialogManager: dialogManager,
                  errorHandler: errorHandler,
                  locationServices: locationServices,
                  locationAuthorizationStatus: locationAuthorizationStatus)
    }

    init(dialogManager: SpecDialogManager,
         errorHandler: SpecErrorHandler,
         locationServices: SpecLocationServices,
         locationAuthorizationStatus: SpecLocationAuthorizationStatus) {
        self.dialogManager = dialogManager
        self.errorHandler = errorHandler
        self.locationServices = locationServices
        self.locationAuthorizationStatus = locationAuthorizationStatus
        locationServices.delegate = self
        locationAuthorizationStatus.delegate = self
    }

    public weak var delegate: CLLocationManagerDelegate?
    public var mostRecentLocation: CLLocation?
    fileprivate let bsFirstArg = CLLocationManager()
    fileprivate var locationRequestInProgress = false
    fileprivate var updatingLocation = false

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
        mostRecentLocation = fakeCurrentLocation
        delegate!.locationManager?(bsFirstArg, didUpdateLocations: [fakeCurrentLocation])
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

// MARK: User's settings in the Settings app
extension SpecLocationManager {

    public func setAuthorizationStatusInSettingsApp(_ status: CLAuthorizationStatus) {
        // should there be some check here to make sure that the user would even
        // have the option to be setting a (certain) status in the Settings app?
        locationAuthorizationStatus.authorizationStatus = status
    }

    public func setLocationServicesEnabledInSettingsApp(_ enabled: Bool) {
        locationServices.locationServices(enabled: enabled)
    }

}

// MARK: LocationManaging
extension SpecLocationManager: LocationManaging {

    public var location: CLLocation? {
        return mostRecentLocation
    }

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

extension SpecLocationManager: SpecLocationServicesDelegate {
    
    func locationServicesEnabledDidChange() {
        sendCurrentStatus()
    }
}

extension SpecLocationManager: SpecLocationAuthorizationStatusDelegate {
    
    func locationAuthorizationStatusDidChange() {
        sendCurrentStatus()
    }
}
