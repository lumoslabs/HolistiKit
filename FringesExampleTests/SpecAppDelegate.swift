@testable import FringesExample

class SpecAppDelegate {
    
    private(set) var window: SpecWindow!
    private(set) weak var dateProvider: SpecDateProvider!
    private(set) weak var networkRequestService: SpecNetworkRequestService!

    func applicationDidLaunch() {
        window = SpecWindow()

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
                                            timerFactory: timerFactory)
        
        appCoordinator.didFinishLaunching(withWindow: window)
    }
}
