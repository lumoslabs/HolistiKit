import Foundation
@testable import SpecUIKitFringes

class SpecNotificationCenter: NotificationCentering {

    private let recorder: Recorder

    init(recorder: Recorder) {
        self.recorder = recorder
    }

    func post(name: NSNotification.Name, object: Any?) {
        recorder.record(.notification(name))
    }
}
