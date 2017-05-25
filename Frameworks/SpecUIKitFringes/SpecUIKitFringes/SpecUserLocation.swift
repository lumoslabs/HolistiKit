import CoreLocation

public class SpecUserLocation {

    public init() { }

    public var location: CLLocation? {
        didSet { notifier.post() }
    }

    public var coordinates: CLLocationCoordinate2D? {
        get { return location?.coordinate }
        set { location = newValue?.asLocation }
    }
    
    private let notifier = SpecMulticaster()
    
    func observe(on observer: Any, selector: Selector) {
        notifier.observe(on: observer, selector: selector)
    }
}
