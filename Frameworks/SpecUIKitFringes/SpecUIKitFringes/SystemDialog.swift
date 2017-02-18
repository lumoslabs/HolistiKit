import Foundation

public class SystemDialog {

    public struct DialogData {
        let identifier: DialogIdentifier
    }

    public init() { }

    public var visibleDialog: DialogIdentifier? {
        return dialogs.first?.identifier
    }

    private var dialogs = [DialogData]()
    
    func addDialog(withIdentifier identifier: DialogData) {
        dialogs.append(identifier)
    }

    @discardableResult
    func popDialog() -> DialogIdentifier? {
        if dialogs.isEmpty { return nil }
        return dialogs.remove(at: 0).identifier
    }
}
