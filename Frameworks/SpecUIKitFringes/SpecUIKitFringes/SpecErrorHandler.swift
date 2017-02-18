public class SpecErrorHandler {

    var errors = [FatalError]()
    private var recordingMode = false

    enum FatalError {
        case appSwitcherNotOpen
        case noScreenshotInAppSwitcher
        case notOnSpringBoard
        case noDialog
        case notAValidDialogResponse
        case noRequestPermissionDialog

        var message: String {
            switch self {
            case .appSwitcherNotOpen:
                return "The user is not in the App Switcher"
            case .noScreenshotInAppSwitcher:
                return "The screenshot is not in the App Switcher"
            case .notOnSpringBoard:
                return "The user is not on the SpringBoard"
            case .noDialog:
                return "There is no dialog visible"
            case .notAValidDialogResponse:
                return "The dialog has no such available response"
            case .noRequestPermissionDialog:
                return "There is no location authorization dialog"
            }
        }
    }

    func error(_ error: FatalError) {
        if recordingMode {
            errors.append(error)
        } else {
            fatalError(error.message)
        }
    }

    func fatalErrorsOff(_ block: @escaping () -> Void) {
        let initialMode = recordingMode
        recordingMode = true
        block()
        recordingMode = initialMode
    }
}
