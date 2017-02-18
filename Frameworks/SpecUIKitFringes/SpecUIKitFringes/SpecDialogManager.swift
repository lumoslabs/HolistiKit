import Foundation

public class SpecDialogManager {

    public init() { }

    public var visibleDialog: DialogIdentifier? {
        return dialogs.first?.identifier
    }

    private var dialogs = [SpecDialog]()
    
    func addDialog(withIdentifier identifier: SpecDialog) {
        dialogs.append(identifier)
    }

    @discardableResult
    func popDialog() -> DialogIdentifier? {
        if dialogs.isEmpty { return nil }
        return dialogs.remove(at: 0).identifier
    }
}
