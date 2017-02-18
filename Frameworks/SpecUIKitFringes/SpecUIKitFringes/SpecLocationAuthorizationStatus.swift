import CoreLocation

public class SpecLocationAuthorizationStatus {

    public init() { }

    weak var delegate: SpecLocationAuthorizationStatusDelegate?
    
    var authorizationStatus = CLAuthorizationStatus.notDetermined {
        didSet { delegate?.locationAuthorizationStatusDidChange() }
    }
}

protocol SpecLocationAuthorizationStatusDelegate: class {

    func locationAuthorizationStatusDidChange()
}
