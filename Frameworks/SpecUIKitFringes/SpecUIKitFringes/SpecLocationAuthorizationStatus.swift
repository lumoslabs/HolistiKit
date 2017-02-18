import CoreLocation

public class SpecLocationAuthorizationStatus {

    public init() { }
    
    var authorizationStatus = CLAuthorizationStatus.notDetermined {
        didSet { SpecAuthorizationStatusChangeNotifier.post() }
    }
}
