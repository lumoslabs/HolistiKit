import SpecUIKitFringes

class FringesSpecSystem: SpecSystem {

    let sharedApplication: SpecSharedApplication
    let dateProvider: SpecDateProvider
    let timeZoneProvider: SpecTimeZoneProvider
    
    weak var urlSession: SpecURLSession!
    weak var locationManager: SpecLocationManager!
    weak var dialogManager: SpecDialogManager!

    override init() {
        self.sharedApplication = SpecSharedApplication()
        self.dateProvider = SpecDateProvider()
        self.timeZoneProvider = SpecTimeZoneProvider()
        super.init()
    }

    override open func createAppDelegateBundle() -> AppDelegateBundle {
        // TODO if these were created via a factory which will aggregate their state it wouldn't be necessary to play this weak/strong game
        let _urlSession = SpecURLSession()
        self.urlSession = _urlSession
        let _dialogManager = SpecDialogManager()
        self.dialogManager = _dialogManager
        let _locationManager = SpecLocationManager(dialogManager: dialogManager)
        self.locationManager = _locationManager
        let appDelegate = SpecAppDelegate(sharedApplication: sharedApplication,
                                          dateProvider: dateProvider,
                                          timeZoneProvider: timeZoneProvider,
                                          urlSession: urlSession,
                                          locationManager: locationManager)
        return AppDelegateBundle(appDelegate: appDelegate,
                                 temporarilyStrong: [urlSession, locationManager, dialogManager])
    }
}
