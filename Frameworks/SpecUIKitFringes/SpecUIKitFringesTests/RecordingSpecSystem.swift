@testable import SpecUIKitFringes

class RecordingSpecSystem: SpecSystem {

    private let recorder: Recorder

    init(recorder: Recorder) {
        self.recorder = recorder
        super.init()
    }

    init(recorder: Recorder, errorHandler: SpecErrorHandler) {
        self.recorder = recorder
        super.init(errorHandler: errorHandler)
    }

    override func createAppDelegateBundle() -> SpecSystem.AppDelegateBundle {
        return SpecSystem.AppDelegateBundle(appDelegate: RecordingSpecApplicationDelegate(recorder: recorder),
                                            temporarilyStrong: [])
    }
}
