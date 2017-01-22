open class SpecApplicationDelegate: SpecApplicationDelegateProtocol {

    public init() { }

    open func applicationDidLaunch() { }
    open func applicationWillResignActive() { }
    open func applicationDidEnterBackground() { }
    open func applicationWillEnterForeground() { }
    open func applicationDidBecomeActive() { }
    open func applicationWillTerminate() { }
}

protocol SpecApplicationDelegateProtocol {
    
    func applicationDidLaunch()
    func applicationWillResignActive()
    func applicationDidEnterBackground()
    func applicationWillEnterForeground()
    func applicationDidBecomeActive()
    func applicationWillTerminate()
}
