class RealityChecker {

    static let shared = RealityChecker()
    var recordedFatalErrors = [FatalError]()
    private var recordingMode = false

    enum FatalError {
        case appSwitcherNotOpen
        case noScreenshotInAppSwitcher
        case notOnSpringBoard

        var message: String {
            switch self {
            case .appSwitcherNotOpen:
                return "The user is not in the App Switcher"
            case .noScreenshotInAppSwitcher:
                return "The screenshot is not in the App Switcher"
            case .notOnSpringBoard:
                return "The user is not on the SpringBoard"
            }
        }
    }

    func error(_ error: FatalError) {
        if recordingMode {
            recordedFatalErrors.append(error)
        } else {
            fatalError(error.message)
        }
    }

    func fatalErrorsOff(_ block: @escaping () -> Void) {
        recordingMode = true
        block()
        recordingMode = false
    }

    func clearRecordedErrors() {
        recordedFatalErrors = []
    }
}
