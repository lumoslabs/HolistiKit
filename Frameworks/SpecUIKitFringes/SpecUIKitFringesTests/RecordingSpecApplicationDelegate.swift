@testable import SpecUIKitFringes

class RecordingSpecApplicationDelegate: SpecApplicationDelegate {
    
    enum Event {
        case applicationDidLaunch
    }

    private(set) var events = [Event]()

    override func applicationDidLaunch() {
        super.applicationDidLaunch()
        add(event: .applicationDidLaunch)
    }
    
    private func add(event: Event) {
        events.append(event)
    }
}
