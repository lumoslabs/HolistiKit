class SpecSystem {

    private(set) var appDelegate: SpecApplicationDelegateProtocol!
    private let appDelegateFactory: SpecApplicationDelegateFactoryProtocol
    private var running = false
    private var inAppSwitcher = false

    init(appDelegateFactory: SpecApplicationDelegateFactoryProtocol) {
        self.appDelegateFactory = appDelegateFactory
    }
    
    public func tapAppIcon() {
        if running {
            appDelegate.applicationWillEnterForeground()
            appDelegate.applicationDidBecomeActive()
        } else {
            appDelegate = appDelegateFactory.create()
            appDelegate.applicationDidLaunch()
            appDelegate.applicationDidBecomeActive()
        }
        running = true
    }
    
    public func tapHomeButton() {
        if inAppSwitcher {
            appDelegate.applicationDidBecomeActive()
        } else {
            appDelegate.applicationWillResignActive()
            appDelegate.applicationDidEnterBackground()
        }
    }
    
    public func doubleTapHomeButton() {
        inAppSwitcher = true
        appDelegate.applicationWillResignActive()
    }

    public func tapAppScreenShot() {
        appDelegate.applicationDidBecomeActive()
    }
}

protocol SpecApplicationDelegateFactoryProtocol {

    func create() -> SpecApplicationDelegateProtocol
}
