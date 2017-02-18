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

    public init(dialogManager: SpecDialogManager) {
        self.dialogManager = dialogManager
    }
    
    fileprivate var fatalErrorsOn: Bool = true
    public fileprivate(set) var erroredWith: InternalInconsistency?

    public weak var delegate: CLLocationManagerDelegate?
    public var mostRecentLocation: CLLocation?
    fileprivate var _authorizationStatus = CLAuthorizationStatus.notDetermined {
        didSet { sendCurrentStatus() }
    }
    fileprivate var _locationServicesEnabled = true {
        didSet { sendCurrentStatus() }
    }
    fileprivate var locationServicesDialogResponseCount = 0
    fileprivate let bsFirstArg = CLLocationManager()
    fileprivate var locationRequestInProgress = false
    fileprivate var updatingLocation = false

    private func sendCurrentStatus() {
        delegate?.locationManager?(bsFirstArg, didChangeAuthorization: authorizationStatus())
    }

}

// MARK: Internal Inconsistencies
extension SpecLocationManager {

    /*
     During normal usage of SpecLocationManager in specs, incorrect usage should
     fatalError immediately. If you're trying to do something that wouldn't be
     possible, or something that CLLocationManager wouldn't actually be doing, we
     should know right away. However, in testing SpecLocationManager itself, we
     want to be able to test these checks where a fatalError would normally be
     occuring. Thus: InternalInconsistency.
     
     Note: When testing for internal inconsistencies, ensure that the test tests
     nothing further afterward, since a fatalError would normally halt operation.
     However, in tests, execution can continue, so any state afterward is unreliable.
     */

    public enum InternalInconsistency {
        case noLocationRequestInProgress
        case notAuthorized
        case noLocationServicesDialog
        case noRequestPermissionDialog
        case noDialog
    }

    public func fatalErrorsOff(block: () -> Void) {
        let previousSetting = fatalErrorsOn
        defer { fatalErrorsOn = previousSetting }
        fatalErrorsOn = false
        block()
    }

    fileprivate func errorWith(_ internalInconsistency: InternalInconsistency) {
        if fatalErrorsOn {
            switch internalInconsistency {
            case .noLocationRequestInProgress:
                fatalError("CLLocationManager would not be sending the location, since there was no location request in progress.")
            case .notAuthorized:
                fatalError("CLLocationManager would not be sending the location, since user has not authorized access.")
            case .noLocationServicesDialog:
                fatalError("The dialog to jump to Location Services was not prompted.")
            case .noDialog:
                fatalError("There is no dialog to be responding to.")
            case .noRequestPermissionDialog:
                fatalError("The requestPermission dialog was not prompted.")
            }
        }
        if erroredWith == nil { erroredWith = internalInconsistency }
    }

}

// MARK: Async callbacks
extension SpecLocationManager {

    public func locationRequestSuccess() {
        if ![.authorizedWhenInUse, .authorizedAlways].contains(authorizationStatus()) {
            errorWith(.notAuthorized)
        }
        if !(locationRequestInProgress || updatingLocation) {
            errorWith(.noLocationRequestInProgress)
        }
        locationRequestInProgress = false
        let fakeCurrentLocation = CLLocation(latitude: 1.0, longitude: 2.0)
        mostRecentLocation = fakeCurrentLocation
        delegate!.locationManager?(bsFirstArg, didUpdateLocations: [fakeCurrentLocation])
    }

}

// MARK: User taps for Location Services
extension SpecLocationManager {

    // TODO expose this as two methods which happen to internally call a single private func
    // Going to settings would also background the app, which cancel would make it active
    /* Both "Settings" and "Cancel" buttons have the same
     effect on the app and state in the ways we care.
     "Settings" will additionally background the app, but
     we don't care about that, at least yet.
     */
    public func tapSettingsOrCancelInDialog() {
        if visibleDialog != .requestJumpToLocationServicesSettings {
            errorWith(.noLocationServicesDialog)
        }
        dialogManager.popDialog()
        locationServicesDialogResponseCount += 1
    }
    
}

// MARK: User taps for authorization dialog prompts
extension SpecLocationManager {

    var visibleDialog: SpecDialogManager.LocationManagerIdentifier? {
        guard let dialog = dialogManager.visibleDialog else { return nil }
        switch dialog {
        case .locationManager(let locationManagerDialog): return locationManagerDialog
        }
    }

    public func tapAllowInDialog() {
        guard let visibleDialog = visibleDialog else {
            errorWith(.noDialog)
            return
        }
        let accessLevel: CLAuthorizationStatus
        switch visibleDialog {
        case .requestAccessWhileInUse: accessLevel = .authorizedWhenInUse
        case .requestAccessAlways: accessLevel = .authorizedAlways
        case .requestJumpToLocationServicesSettings:
            fatalErrorWrongDialog()
            // it needs to be set, even though we don't care about it now
            accessLevel = .authorizedAlways
        }
        respondToAccessDialog(accessLevel)
    }
    
    public func tapDoNotAllowAccessInDialog() {
        respondToAccessDialog(.denied)
    }

    private func fatalErrorWrongDialog() {
        errorWith(.noRequestPermissionDialog)
    }

    private func respondToAccessDialog(_ level: CLAuthorizationStatus) {
        guard let dialog = visibleDialog else {
            errorWith(.noDialog)
            return
        }
        // the dialog must currently be one asking for authorization
        if ![.requestAccessWhileInUse, .requestAccessAlways].contains(dialog) {
            fatalErrorWrongDialog()
        }
        // the authorization must be one that can come from a user tap on the dialog
        if ![.denied, .authorizedWhenInUse, .authorizedAlways].contains(level) {
            fatalError("This is not a valid user response from the dialog.")
        }
        dialogManager.popDialog()
        _authorizationStatus = level
    }
    
}

// MARK: User's settings in the Settings app
extension SpecLocationManager {

    public func setAuthorizationStatusInSettingsApp(_ status: CLAuthorizationStatus) {
        // should there be some check here to make sure that the user would even
        // have the option to be setting a (certain) status in the Settings app?
        _authorizationStatus = status
    }

    public func setLocationServicesEnabledInSettingsApp(_ enabled: Bool) {
        _locationServicesEnabled = enabled
    }

}

// MARK: requestWhenInUseAuthorization outcomes
extension SpecLocationManager {
    
    fileprivate func requestWhenInUseWhileNotDetermined() {
        fatalErrorIfCurrentlyADialog()
        dialogManager.addDialog(LocationManagerDialog(identifier: .requestAccessWhileInUse))
    }

    fileprivate func requestWhenInUseWhileDeniedDueToLocationServices() {
        if !iOSwillPermitALocationServicesDialogToBeShown { return }
        fatalErrorIfCurrentlyADialog()
        dialogManager.addDialog(LocationManagerDialog(identifier: .requestJumpToLocationServicesSettings))
    }

    private var iOSwillPermitALocationServicesDialogToBeShown: Bool {
        // iOS will only ever show the user this dialog twice for this app.
        // It only counts as being shown if the user responds. For example,
        // the following things can dismiss the dialog without it counting:
        // * Locking the device.
        // * Receiving a call, accepting, and then clicking Home.
        return locationServicesDialogResponseCount < 2
    }

    // TODO this is not the case.
    // add tests to SpecDialogManager to show how they stack and affect app active/inactive
    private func fatalErrorIfCurrentlyADialog() {
        guard let dialog = visibleDialog else { return }
        fatalError("There is already a dialog displayed: \(dialog). If showing another one would create a stack of dialogs, then update `dialog` to handle a stack.")
    }

}

// MARK: requestLocation outcomes
extension SpecLocationManager {

    fileprivate func requestLocationWhileNotDetermined() {
        let error = NSError(domain: kCLErrorDomain, code: 0, userInfo: nil)
        // this actually happens about 10 seconds later
        delegate!.locationManager!(bsFirstArg, didFailWithError: error)
    }

    fileprivate func requestLocationWhileWhenInUse() {
        locationRequestInProgress = true
    }

}

// MARK: startUpdatingLocation outcomes
extension SpecLocationManager {

    fileprivate func startUpdatingLocationWhileWhenInUse() {
        updatingLocation = true
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
            if _authorizationStatus == .denied { break }
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
        return _authorizationStatus
    }

    public func isLocationServicesEnabled() -> Bool {
        return _locationServicesEnabled
    }

}