class RealityChecker {

    static let shared = RealityChecker()
    var recordedFatalError: FatalError?
    private var recordingMode = false

    enum FatalError {
        case notInAppSwitcher

        var message: String {
            switch self {
            case .notInAppSwitcher:
                return "The user is not in the App Switcher"
            }
        }
    }

    func error(_ error: FatalError) {
        if recordingMode {
            self.recordedFatalError = error
        } else {
            fatalError(error.message)
        }
    }

    func fatalErrorsOff(_ block: @escaping () -> Void) {
        recordingMode = true
        block()
        recordingMode = false
    }
}
