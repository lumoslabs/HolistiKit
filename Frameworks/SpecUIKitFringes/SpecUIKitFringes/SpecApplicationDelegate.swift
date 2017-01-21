open class SpecApplicationDelegate {

    public init() { }

    open func applicationDidLaunch() { }
    open func applicationWillResignActive() { }
    open func applicationDidEnterBackground() { }
    open func applicationWillEnterForeground() { }
    open func applicationDidBecomeActive() { }
    open func applicationWillTerminate() { }

    private var running = false
    
    public func tapAppIcon() {
        if running {
            applicationWillEnterForeground()
            applicationDidBecomeActive()
        } else {
            applicationDidLaunch()
            applicationDidBecomeActive()
        }
        running = true
    }
    
    public func tapHomeButton() {
        applicationWillResignActive()
        applicationDidEnterBackground()
    }
    
    public func doubleTapHomeButton() {
        applicationWillResignActive()
    }
}
