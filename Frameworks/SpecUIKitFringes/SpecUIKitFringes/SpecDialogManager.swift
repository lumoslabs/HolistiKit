import Foundation

public class SpecDialogManager {

    private let realityChecker: RealityChecker

    public init(realityChecker: RealityChecker) {
        self.realityChecker = realityChecker
    }

    private var _visibleDialog: SpecDialog? {
        return dialogs.first
    }

    public var visibleDialog: DialogIdentifier? {
        return _visibleDialog?.identifier
    }

    private var dialogs = [SpecDialog]()
    
    func addDialog(_ identifier: SpecDialog) {
        dialogs.append(identifier)
    }

    public enum Response {
        case allow
        case dontAllow
    }

    func tap(_ response: Response) {
        let dialog = popDialog()!
        let isValidResponse = dialog.responded(with: response)
        if !isValidResponse {
            realityChecker.error(.notAValidDialogResponse)
        }
    }

    func popDialog() -> SpecDialog? {
        if dialogs.isEmpty { return nil }
        return dialogs.remove(at: 0)
    }
}
