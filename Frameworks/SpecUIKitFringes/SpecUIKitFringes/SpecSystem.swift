open class SpecSystem {
    
    public init() { }

    public private(set) var appDelegate: SpecApplicationDelegateProtocol!
    private var locations: [Location] = [.springBoard]
    private var screenshotInAppSwitcher = false

    private enum Location {
        case springBoard
        case app
        case appSwitcher
    }

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
        errorIfNotOnSpringBoard()
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
        screenshotInAppSwitcher = true
        move(to: .app)
    }

    public func tapHomeButton() {
        switch location {
        case .appSwitcher:
            if let appDelegate = appDelegate, cameFrom(.app) {
                appDelegate.applicationDidBecomeActive()
                move(to: .app)
            } else {
                move(to: .springBoard)
            }
        case .app:
            appDelegate.applicationWillResignActive()
            appDelegate.applicationDidEnterBackground()
            move(to: .springBoard)
        case .springBoard:
            break;
        }
    }
    
    public func doubleTapHomeButton() {
        move(to: .appSwitcher)
        appDelegate?.applicationWillResignActive()
    }

    public func tapAppScreenshot() {
        errorIfAppSwitcherIsNotOpen()
        errorIfNoScreenshotInAppSwitcher()
        if let appDelegate = appDelegate {
            appDelegate.applicationDidBecomeActive()
        } else {
        }
    }

    public func swipeUpAppScreenshot() {
        appDelegate.applicationDidEnterBackground()
        appDelegate.applicationWillTerminate()
        appDelegate = nil
        screenshotInAppSwitcher = false
    }

    private func move(to location: Location) {
        locations.append(location)
    }

    private func at(_ location: Location) -> Bool {
        return self.location == location
    }

    private var location: Location {
        return locations.last!
    }

    private func cameFrom(_ location: Location) -> Bool {
        return lastLocation == location
    }

    private var lastLocation: Location {
        return locations[locations.count - 2]
    }

    private func errorIfNotOnSpringBoard() {
        if !at(.springBoard) { RealityChecker.shared.error(.notOnSpringBoard) }
    }

    private func errorIfAppSwitcherIsNotOpen() {
        if !at(.appSwitcher) { RealityChecker.shared.error(.appSwitcherNotOpen) }
    }

    private func errorIfNoScreenshotInAppSwitcher() {
        if !screenshotInAppSwitcher { RealityChecker.shared.error(.noScreenshotInAppSwitcher) }
    }
}