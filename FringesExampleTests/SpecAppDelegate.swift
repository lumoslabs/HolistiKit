import SpecUIKitFringes
@testable import FringesExample

class SpecAppDelegate: SpecApplicationDelegateProtocol {
    
    private(set) var window: SpecWindow!
    
    private weak var sharedApplication: SpecSharedApplication!
    private weak var dateProvider: SpecDateProvider!
    private weak var timeZoneProvider: SpecTimeZoneProvider!
    private weak var networkRequestService: SpecNetworkRequestService!

    init(sharedApplication: SpecSharedApplication,
         dateProvider: SpecDateProvider,
         timeZoneProvider: SpecTimeZoneProvider,
         networkRequestService: SpecNetworkRequestService) {
        self.sharedApplication = sharedApplication
        self.dateProvider = dateProvider
        self.timeZoneProvider = timeZoneProvider
        self.networkRequestService = networkRequestService
    }

    func applicationDidLaunch() {

        window = SpecWindow()

        let examplesNavigationControllerFactory = SpecExamplesNavigationControllingFactory()
        let examplesViewControllerFactory = SpecExamplesViewControllingFactory()
        let timerViewControllerFactory = SpecTimerViewControllerFactory()
        let networkRequestViewControllerFactory = SpecNetworkRequestViewControllerFactory()
        let dateViewControllerFactory = SpecDateViewControllerFactory()
        let errorLogger = SpecErrorLogger()
        let timerFactory = SpecTimerFactory(dateProvider: dateProvider)
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
