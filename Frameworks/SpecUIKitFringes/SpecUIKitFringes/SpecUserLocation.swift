import CoreLocation

public class SpecUserLocation {

    var location: CLLocation? {
        didSet { notifier.post() }
    }
    private let notifier = SpecMulticaster()
    
    func observe(on observer: Any, selector: Selector) {
        notifier.observe(on: observer, selector: selector)
    }
}
