public protocol SpecDialog {

    var identifier: SpecDialogManager.DialogIdentifier { get }
}

public struct LocationManagerDialog: SpecDialog {

    public let identifier: SpecDialogManager.DialogIdentifier

    init(identifier locationManagerIdentifier: SpecDialogManager.LocationManagerIdentifier) {
        self.identifier = .locationManager(locationManagerIdentifier)
    }
}
