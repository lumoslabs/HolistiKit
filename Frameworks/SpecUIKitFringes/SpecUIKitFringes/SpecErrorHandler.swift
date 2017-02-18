/*
 During normal usage of Spec fake classes in specs, incorrect usage should
 fatalError immediately. If you're trying to do something that wouldn't be
 possible, or something that wouldn't actually be happening/possible, we
 should know right away. However, in testing this fatalError behavior itself,
 we need to be able to log these errors instead of fatal erroring.

 Note: When testing for these errors, ensure that the tests test nothing 
 further afterward, since a fatalError would normally halt operation.
 However, in tests, execution can continue, so any state after the error is 
 unreliable.
 */
    
public class SpecErrorHandler {

    var recordedError: FatalError?
    private var recordingMode = false

    enum FatalError {
        case appSwitcherNotOpen
        case noScreenshotInAppSwitcher
        case notOnSpringBoard
        case noDialog
        case notAValidDialogResponse
        case noLocationRequestInProgress
        case notAuthorized

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
            case .noLocationRequestInProgress:
                return "CLLocationManager would not be sending the location, since there was no location request in progress."
            case .notAuthorized:
                return "CLLocationManager would not be sending the location, since user has not authorized access."
            }
        }
    }

    func error(_ error: FatalError) {
        if recordingMode {
            record(error)
        } else {
            fatalError(error.message)
        }
    }

    private func record(_ error: FatalError) {
        if recordedError == nil {
            recordedError = error
        }
    }

    func fatalErrorsOff(_ block: @escaping () -> Void) {
        let initialMode = recordingMode
        recordingMode = true
        block()
        recordingMode = initialMode
    }
}
