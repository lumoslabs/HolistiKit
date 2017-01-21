import SpecUIKitFringes
@testable import FringesExample

class SpecAppDelegate: SpecApplicationDelegate {
    
    private(set) var window: SpecWindow!
    private(set) weak var dateProvider: SpecDateProvider!
    private(set) weak var networkRequestService: SpecNetworkRequestService!
    private(set) weak var sharedApplication: SpecSharedApplication!

    func applicationDidLaunch() {
        window = SpecWindow()

        let _sharedApplication = SpecSharedApplication()
        sharedApplication = _sharedApplication
        let _networkRequestService = SpecNetworkRequestService()
        networkRequestService = _networkRequestService
        let examplesNavigationControllerFactory = SpecExamplesNavigationControllingFactory()
        let examplesViewControllerFactory = SpecExamplesViewControllingFactory()
        let timerViewControllerFactory = SpecTimerViewControllerFactory()
        let networkRequestViewControllerFactory = SpecNetworkRequestViewControllerFactory()
        let dateViewControllerFactory = SpecDateViewControllerFactory()
        let _dateProvider = SpecDateProvider()
        dateProvider = _dateProvider
        let timeZoneProvider = SpecTimeZoneProvider()
        let errorLogger = SpecErrorLogger()
        let timerFactory = SpecTimerFactory(dateProvider: _dateProvider)
        let appCoordinator = AppCoordinator(examplesNavigationControllerFactory: examplesNavigationControllerFactory,
                                            examplesViewControllerFactory: examplesViewControllerFactory,
                                            timerViewControllerFactory: timerViewControllerFactory,
                                            networkRequestViewControllerFactory: networkRequestViewControllerFactory,
                                            dateViewControllerFactory: dateViewControllerFactory,
                                            dateProvider: dateProvider,
                                            timeZoneProvider: timeZoneProvider,
                                            errorLogger: errorLogger,
                                            networkRequestService: networkRequestService,
                                            timerFactory: timerFactory,
                                            sharedApplication: sharedApplication)
        
        appCoordinator.didFinishLaunching(withWindow: window)
    }
}
