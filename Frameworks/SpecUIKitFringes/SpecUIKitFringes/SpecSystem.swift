open class SpecSystem {

    let locationServices = SpecLocationServices()
    let locationAuthorizationStatus = SpecLocationAuthorizationStatus()
    private let errorHandler: SpecErrorHandler
    private let notificationCenter: NotificationCentering
    
    public init() {
        self.errorHandler = SpecErrorHandler()
        self.notificationCenter = NotificationCenter.default
    }

    init(errorHandler: SpecErrorHandler,
         notificationCenter: NotificationCentering) {
        self.errorHandler = errorHandler
        self.notificationCenter = notificationCenter
    }

    public private(set) var appDelegate: SpecApplicationDelegateProtocol!
    private var locations: [Location] = [.springBoard]
    private var screenshotInAppSwitcher = false

    var settingsApp: SpecSettingsApp {
        assert(location: .settingsApp)
        return SpecSettingsApp(locationAuthorizationStatus: locationAuthorizationStatus,
                               locationServices: locationServices)
    }

    public enum Location {
        case springBoard
        case app
        case appSwitcher
        case settingsApp
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
        assert(location: .springBoard)
        if appDelegate != nil {
            applicationWillEnterForeground()
            applicationDidBecomeActive()
        } else {
            launch()
        }
    }
    
    public func tapSettingsAppIcon() {
        assert(location: .springBoard)
        move(to: .settingsApp)
    }

    private func launch() {
        let newAppDelegateBundle = createAppDelegateBundle()
        appDelegate = newAppDelegateBundle.appDelegate
        applicationDidLaunch()
        applicationDidBecomeActive()
        screenshotInAppSwitcher = true
        move(to: .app)
    }

    private func applicationWillEnterForeground() {
        appDelegate.applicationWillEnterForeground()
        notificationCenter.post(name: .UIApplicationWillEnterForeground, object: nil)
    }

    private func applicationDidLaunch() {
        appDelegate.applicationDidLaunch()
        notificationCenter.post(name: .UIApplicationDidFinishLaunching, object: nil)
    }

    private func applicationDidBecomeActive() {
        appDelegate.applicationDidBecomeActive()
        notificationCenter.post(name: .UIApplicationDidBecomeActive, object: nil)
    }
    
    private func applicationDidEnterBackground() {
        appDelegate.applicationDidEnterBackground()
        notificationCenter.post(name: .UIApplicationDidEnterBackground, object: nil)
    }

    private func applicationWillTerminate() {
        appDelegate.applicationWillTerminate()
        notificationCenter.post(name: .UIApplicationWillTerminate, object: nil)
    }
    
    private func applicationWillResignActive() {
        appDelegate.applicationWillResignActive()
        notificationCenter.post(name: .UIApplicationWillResignActive, object: nil)
    }

    public func tapHomeButton() {
        switch location {
        case .appSwitcher:
            anyHomeButtonTapInAppSwitcher()
        case .app:
            applicationWillResignActive()
            applicationDidEnterBackground()
            move(to: .springBoard)
        case .settingsApp:
            move(to: .springBoard)
        case .springBoard:
            break;
        }
    }

    private func anyHomeButtonTapInAppSwitcher() {
        if appDelegate != nil && cameFrom(.app) {
            applicationDidBecomeActive()
            move(to: .app)
        } else {
            move(to: .springBoard)
        }
    }

    public func doubleTapHomeButton() {
        switch location {
        case .appSwitcher:
            anyHomeButtonTapInAppSwitcher()
        case .app:
            applicationWillResignActive()
            move(to: .appSwitcher)
        case .springBoard, .settingsApp:
            move(to: .appSwitcher)
        }
    }

    public func tapAppScreenshot() {
        assert(location: .appSwitcher)
        errorIfNoScreenshotInAppSwitcher()
        if appDelegate != nil {
            applicationDidBecomeActive()
        } else {
        }
    }

    public func swipeUpAppScreenshot() {
        applicationDidEnterBackground()
        applicationWillTerminate()
        appDelegate = nil
        screenshotInAppSwitcher = false
    }

    internal func jumpToSettings() {
        applicationWillResignActive()
        applicationDidEnterBackground()
        move(to: .settingsApp)
    }

    private func move(to location: Location) {
        locations.append(location)
    }

    private func at(_ location: Location) -> Bool {
        return self.location == location
    }

    public var location: Location {
        return locations.last!
    }

    private func cameFrom(_ location: Location) -> Bool {
        return lastLocation == location
    }

    private var lastLocation: Location {
        return locations[locations.count - 2]
    }

    private func assert(location: Location) {
        if !at(location) { errorHandler.error(.expectedLocation(location)) }
    }

    private func errorIfNoScreenshotInAppSwitcher() {
        if !screenshotInAppSwitcher { errorHandler.error(.noScreenshotInAppSwitcher) }
    }
}
