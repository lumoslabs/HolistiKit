import CoreLocation

public protocol LocationManaging: class {

    func authorizationStatus() -> CLAuthorizationStatus
    func isLocationServicesEnabled() -> Bool
    weak var delegate: LocationManagingDelegate? { get set }
    var location: CLLocation? { get }
    func requestLocation()
    func requestWhenInUseAuthorization()
    func startUpdatingLocation()
}

public protocol LocationManagingDelegate: class {
    
    func locationManager(didUpdateLocations: [CLLocation])
    func locationManager(didChangeAuthorization: CLAuthorizationStatus)
    func locationManager(didFailWithError: Error)
}

public extension LocationManagingDelegate {
    
    func locationManager(didUpdateLocations: [CLLocation]) { }
    func locationManager(didChangeAuthorization: CLAuthorizationStatus) { }
    func locationManager(didFailWithError: Error) { }
}

class LocationManager: NSObject, LocationManaging, CLLocationManagerDelegate {

    weak var delegate: LocationManagingDelegate?
    var location: CLLocation? { return clLocationManager.location }
    private let clLocationManager: CLLocationManager

    public override convenience init() {
        self.init(clLocationManager: CLLocationManager())
    }

    init(clLocationManager: CLLocationManager) {
        self.clLocationManager = clLocationManager
        super.init()
        self.clLocationManager.delegate = self
    }
    
    public func authorizationStatus() -> CLAuthorizationStatus { return type(of: clLocationManager).authorizationStatus() }
    public func isLocationServicesEnabled() -> Bool { return type(of: clLocationManager).locationServicesEnabled() }
    func requestLocation() { clLocationManager.requestLocation() }
    func requestWhenInUseAuthorization() { clLocationManager.requestWhenInUseAuthorization() }
    func startUpdatingLocation() { clLocationManager.startUpdatingLocation() }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        delegate?.locationManager(didUpdateLocations: locations)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        delegate?.locationManager(didChangeAuthorization: status)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.locationManager(didFailWithError: error)
    }
}

public protocol LocationManagingFactoryProtocol {

    func create() -> LocationManaging
}

public class LocationManagerFactory: LocationManagingFactoryProtocol {

    public init() { }

    public func create() -> LocationManaging {
        return LocationManager()
    }
}
