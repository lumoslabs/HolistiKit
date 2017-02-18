import Foundation

public protocol DialogData {

    var identifier: SpecDialogManager.DialogIdentifier { get }
}

public struct LocationManagerDialog: DialogData {

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
