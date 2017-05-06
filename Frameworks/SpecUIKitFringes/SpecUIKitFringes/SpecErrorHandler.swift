/*
 During normal usage of Spec classes, incorrect usage should fatalError 
 immediately. If you're trying to do something that wouldn't be possible,
 or something that wouldn't actually be happening, we should know right 
 away. However, in testing this fatalError behavior itself, we need to be 
 able to log these errors instead of fatal erroring.

 Note: When testing for these errors, ensure that the tests test nothing 
 further afterward, since a fatalError would normally halt operation.
 However, if logging instead of fatal erroring, execution continues. So,
 any state after the error is unreliable.
 */

class SpecErrorHandler {

    var recordedError: FatalError?
    private var recordingMode = false

    enum FatalError: CustomStringConvertible {
        case noScreenshotInAppSwitcher
        case expectedLocation(SpecSystem.Location)
        case noDialog
        case notAValidDialogResponse
        case noSuchPreferencesSpecifier(SpecSettingsPreferences.Specifier, [SpecSettingsPreferences.Specifier])
        case noSuchURLRequestInProgress(SpecURLRequestIdentifier, [SpecURLSessionDataTask])

        var description: String {
            switch self {
            case .expectedLocation(let location):
                return "Expected user to be located at \(location)"
            case .noScreenshotInAppSwitcher:
                return "The screenshot is not in the App Switcher"
            case .noDialog:
                return "There is no dialog visible"
            case .notAValidDialogResponse:
                return "The dialog has no such available response"
            case .noSuchURLRequestInProgress(let id, let requests):
                return "There was no such URL request in the app at the moment for \(id). Running requests were: \(requests)"
            case .noSuchPreferencesSpecifier(let specifier, let specifiers):
                return "There is no such Preferences Specifier in the Settings Bundle for \(specifier). Available specifiers are \(specifiers)"
            }
        }
    }

    func error(_ error: FatalError) {
        if recordingMode {
            record(error)
        } else {
            fatalError(error.description)
        }
    }

    private func record(_ error: FatalError) {
        if recordedError == nil {
            recordedError = error
        }
    }

    func fatalErrorsOff(_ block: () -> Void) {
        let initialMode = recordingMode
        recordingMode = true
        block()
        recordingMode = initialMode
    }
}

extension SpecErrorHandler.FatalError: Equatable {}
func ==(lhs: SpecErrorHandler.FatalError, rhs: SpecErrorHandler.FatalError) -> Bool {
    switch (lhs, rhs) {
    case (.expectedLocation(let lLocation), .expectedLocation(let rLocation)):
        return lLocation == rLocation
    case (.noScreenshotInAppSwitcher, .noScreenshotInAppSwitcher): return true
    case (.noDialog, .noDialog): return true
    case (.notAValidDialogResponse, .notAValidDialogResponse): return true
    case (.noSuchURLRequestInProgress, .noSuchURLRequestInProgress): return true
    case (.noSuchPreferencesSpecifier(let lSpecifier, let lSpecifiers), .noSuchPreferencesSpecifier(let rSpecifier, let rSpecifiers)):
        return lSpecifier == rSpecifier && lSpecifiers == rSpecifiers
    default: fatalError("We should never need to test for inequality in tests.")
    }
}
