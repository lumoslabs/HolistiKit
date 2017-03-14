public protocol SpecApplicationDelegateProtocol {
    
    var window: UIWindow! { get }
    
    func applicationDidLaunch()
    func applicationWillResignActive()
    func applicationDidEnterBackground()
    func applicationWillEnterForeground()
    func applicationDidBecomeActive()
    func applicationWillTerminate()
}

public extension SpecApplicationDelegateProtocol {
    
    func applicationDidLaunch() { }
    func applicationWillResignActive() { }
    func applicationDidEnterBackground() { }
    func applicationWillEnterForeground() { }
    func applicationDidBecomeActive() { }
    func applicationWillTerminate() { }
}
