import SpecUIKitFringes

class RecordingSpecApplicationDelegate: SpecApplicationDelegateProtocol {
    
    public var window: UIWindow!
    private let recorder: Recorder

    init(recorder: Recorder) {
        self.recorder = recorder
    }

    func applicationDidLaunch() {
        add(event: .applicationDidLaunch)
    }
    
    func applicationWillResignActive() {
        add(event: .applicationWillResignActive)
    }
    
    func applicationDidEnterBackground() {
        add(event: .applicationDidEnterBackground)
    }
    
    func applicationWillEnterForeground() {
        add(event: .applicationWillEnterForeground)
    }
    
    func applicationDidBecomeActive() {
        add(event: .applicationDidBecomeActive)
    }
    
    func applicationWillTerminate() {
        add(event: .applicationWillTerminate)
    }
    
    private func add(event: Recorder.Event) {
        recorder.record(event)
    }
}
