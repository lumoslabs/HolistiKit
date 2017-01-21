open class SpecApplicationDelegate {

    public init() { }

    open func applicationDidLaunch() { }
    open func applicationWillResignActive() { }
    open func applicationDidEnterBackground() { }
    open func applicationWillEnterForeground() { }
    open func applicationDidBecomeActive() { }
    open func applicationWillTerminate() { }
    
    public func tapAppIcon() {
        applicationDidLaunch()
        applicationDidBecomeActive()
    }
    
    public func tapHomeButton() {
        applicationWillResignActive()
        applicationDidEnterBackground()
    }
}
