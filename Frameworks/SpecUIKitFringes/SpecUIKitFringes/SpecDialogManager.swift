import Foundation

public class SpecDialogManager {

    public init() { }

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
    }

    func tap(_ response: Response) {
        let dialog = popDialog()!
        dialog.responded(with: response)
    }

    func popDialog() -> SpecDialog? {
        if dialogs.isEmpty { return nil }
        return dialogs.remove(at: 0)
    }
}
