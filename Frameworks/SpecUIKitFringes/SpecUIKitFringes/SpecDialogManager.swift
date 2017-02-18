import Foundation

public protocol SpecDialog {

    var identifier: SpecDialogManager.DialogIdentifier { get }
}

public struct LocationManagerDialog: SpecDialog {

    public let identifier: SpecDialogManager.DialogIdentifier

    init(identifier locationManagerIdentifier: SpecDialogManager.LocationManagerIdentifier) {
        self.identifier = .locationManager(locationManagerIdentifier)
    }
}

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
