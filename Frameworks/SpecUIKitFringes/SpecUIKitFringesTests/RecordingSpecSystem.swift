@testable import SpecUIKitFringes

class RecordingSpecSystem: SpecSystem {

    private let recorder: Recorder

    init(recorder: Recorder,
         errorHandler: SpecErrorHandler,
         notificationCenter: SpecNotificationCenter) {
        self.recorder = recorder
        super.init(errorHandler: errorHandler,
                   notificationCenter: notificationCenter)
    }

    override func createAppDelegateBundle() -> SpecSystem.AppDelegateBundle {
        return SpecSystem.AppDelegateBundle(appDelegate: RecordingSpecApplicationDelegate(recorder: recorder),
                                            temporarilyStrong: [])
    }
}
