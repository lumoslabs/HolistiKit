@testable import FringesExample

class SpecAppDelegate {
    
    private(set) var window: SpecWindow!

    private(set) weak var dateProvider: SpecDateProvider!

    func applicationDidLaunch() {
        window = SpecWindow()
        
        let dashboardNavigationControllerFactory = SpecDashboardNavigationControllingFactory()
        let dashboardViewControllerFactory = SpecDashboardViewControllingFactory()
        let timerViewControllerFactory = SpecTimerViewControllerFactory()
        let dateViewControllerFactory = SpecDateViewControllerFactory()
        let _dateProvider = SpecDateProvider()
        dateProvider = _dateProvider
        let timeZoneProvider = SpecTimeZoneProvider()
        let errorLogger = SpecErrorLogger()
        let appCoordinator = AppCoordinator(dashboardNavigationControllerFactory: dashboardNavigationControllerFactory,
                                            dashboardViewControllerFactory: dashboardViewControllerFactory,
                                            timerViewControllerFactory: timerViewControllerFactory,
                                            dateViewControllerFactory: dateViewControllerFactory,
                                            dateProvider: dateProvider,
                                            timeZoneProvider: timeZoneProvider,
                                            errorLogger: errorLogger)
        
        appCoordinator.didFinishLaunching(withWindow: window)
    }
}
