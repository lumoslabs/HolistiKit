import SpecUIKitFringes

class FringesSpecSystem: SpecSystem {

    let sharedApplication: SpecSharedApplication
    let dateProvider: SpecDateProvider
    let timeZoneProvider: SpecTimeZoneProvider
    
    weak var urlSession: SpecURLSession!
    weak var locationManager: SpecLocationManager!

    override init() {
        self.sharedApplication = SpecSharedApplication()
        self.dateProvider = SpecDateProvider()
        self.timeZoneProvider = SpecTimeZoneProvider()
        super.init()
    }

    override open func createAppDelegateBundle() -> AppDelegateBundle {
        let _urlSession = SpecURLSession()
        self.urlSession = _urlSession
        let _locationManager = SpecLocationManager()
        self.locationManager = _locationManager
        let appDelegate = SpecAppDelegate(sharedApplication: sharedApplication,
                                          dateProvider: dateProvider,
                                          timeZoneProvider: timeZoneProvider,
                                          urlSession: urlSession,
                                          locationManager: locationManager)
        return AppDelegateBundle(appDelegate: appDelegate,
                                 temporarilyStrong: [urlSession, locationManager])
    }
}
