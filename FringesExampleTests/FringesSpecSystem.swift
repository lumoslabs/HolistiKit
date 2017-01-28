import SpecUIKitFringes

class FringesSpecSystem: SpecSystem {

    let sharedApplication: SpecSharedApplication
    let dateProvider: SpecDateProvider
    let timeZoneProvider: SpecTimeZoneProvider
    
    weak var urlSession: SpecURLSession!

    override init() {
        self.sharedApplication = SpecSharedApplication()
        self.dateProvider = SpecDateProvider()
        self.timeZoneProvider = SpecTimeZoneProvider()
        super.init()
    }

    override open func createAppDelegateBundle() -> AppDelegateBundle {
        let _urlSession = SpecURLSession()
        self.urlSession = _urlSession
        let appDelegate = SpecAppDelegate(sharedApplication: sharedApplication,
                                          dateProvider: dateProvider,
                                          timeZoneProvider: timeZoneProvider,
                                          urlSession: urlSession)
        return AppDelegateBundle(appDelegate: appDelegate,
                                 temporarilyStrong: [urlSession])
    }
}
