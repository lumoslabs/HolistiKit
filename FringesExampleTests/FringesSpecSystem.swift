import SpecUIKitFringes

class FringesSpecSystem: SpecSystem {

    let sharedApplication: SpecSharedApplication
    let dateProvider: SpecDateProvider
    let timeZoneProvider: SpecTimeZoneProvider
    
    weak var networkRequestService: SpecNetworkRequestService!

    override init() {
        self.sharedApplication = SpecSharedApplication()
        self.dateProvider = SpecDateProvider()
        self.timeZoneProvider = SpecTimeZoneProvider()
        super.init()
    }

    override open func createAppDelegateBundle() -> AppDelegateBundle {
        let _networkRequestService = SpecNetworkRequestService()
        self.networkRequestService = _networkRequestService
        let appDelegate = SpecAppDelegate(sharedApplication: sharedApplication,
                                          dateProvider: dateProvider,
                                          timeZoneProvider: timeZoneProvider,
                                          networkRequestService: networkRequestService)
        return AppDelegateBundle(appDelegate: appDelegate,
                                 temporarilyStrong: [networkRequestService])
    }
}
