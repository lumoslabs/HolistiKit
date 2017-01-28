open class SpecSystem {
    
    public init() { }

    public private(set) var appDelegate: SpecApplicationDelegateProtocol!
    private var inAppSwitcher = false

    public struct AppDelegateBundle {
        let appDelegate: SpecApplicationDelegateProtocol
        let temporarilyStrong: [Any]

        public init(appDelegate: SpecApplicationDelegateProtocol,
                    temporarilyStrong: [Any]) {
            self.appDelegate = appDelegate
            // this holds a strong reference of dependencies long enough
            // for applicationDidLaunch to be called, and for the actual
            // dependent objects to get the dependencies. Neither
            // AppDelegate nor the SpecSystem should retain them.
            self.temporarilyStrong = temporarilyStrong
        }
    }

    open func createAppDelegateBundle() -> AppDelegateBundle {
        fatalError("This class is abstract")
    }
    
    public func tapAppIcon() {
        if let appDelegate = appDelegate {
            appDelegate.applicationWillEnterForeground()
            appDelegate.applicationDidBecomeActive()
        } else {
            launch()
        }
    }

    private func launch() {
        let newAppDelegateBundle = createAppDelegateBundle()
        appDelegate = newAppDelegateBundle.appDelegate
        appDelegate.applicationDidLaunch()
        appDelegate.applicationDidBecomeActive()
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

    public func tapAppScreenshot() {
        if !inAppSwitcher { RealityChecker.shared.error(.notInAppSwitcher) }
        if let appDelegate = appDelegate {
            appDelegate.applicationDidBecomeActive()
        } else {
        }
    }

    public func swipeUpAppScreenshot() {
        appDelegate.applicationDidEnterBackground()
        appDelegate.applicationWillTerminate()
        appDelegate = nil
    }
}
