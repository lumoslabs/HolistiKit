import Foundation

public protocol DialogData {

    var identifier: SystemDialog.DialogIdentifier { get }
}

public struct LocationManagerDialog: DialogData {

    public let identifier: SystemDialog.DialogIdentifier

    init(identifier locationManagerIdentifier: SystemDialog.LocationManagerIdentifier) {
        self.identifier = .locationManager(locationManagerIdentifier)
    }
}

public class SystemDialog {

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
