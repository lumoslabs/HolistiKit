@testable import SpecUIKitFringes

class RecordingSpecApplicationDelegate: SpecApplicationDelegate {
    
    enum Event {
        case applicationDidLaunch
        case applicationWillResignActive
        case applicationDidEnterBackground
        case applicationWillEnterForeground
        case applicationDidBecomeActive
        case applicationWillTerminate
    }

    private(set) var events = [Event]()

    func clearEvents() {
        events.removeAll()
    }

    override func applicationDidLaunch() {
        super.applicationDidLaunch()
        add(event: .applicationDidLaunch)
    }
    
    override func applicationWillResignActive() {
        super.applicationWillResignActive()
        add(event: .applicationWillResignActive)
    }
    
    override func applicationDidEnterBackground() {
        super.applicationDidEnterBackground()
        add(event: .applicationDidEnterBackground)
    }
    
    override func applicationWillEnterForeground() {
        super.applicationWillEnterForeground()
        add(event: .applicationWillEnterForeground)
    }
    
    override func applicationDidBecomeActive() {
        super.applicationDidBecomeActive()
        add(event: .applicationDidBecomeActive)
    }
    
    override func applicationWillTerminate() {
        super.applicationWillTerminate()
        add(event: .applicationWillTerminate)
    }
    
    private func add(event: Event) {
        events.append(event)
    }
}
