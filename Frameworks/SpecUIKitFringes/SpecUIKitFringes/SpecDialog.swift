public protocol SpecDialog {

    var identifier: SpecDialogManager.DialogIdentifier { get }
    func responded(with: SpecDialogManager.Response)
}

public struct LocationManagerDialog: SpecDialog {

    public let identifier: SpecDialogManager.DialogIdentifier

    init(identifier locationManagerIdentifier: SpecDialogManager.LocationManagerIdentifier) {
        self.identifier = .locationManager(locationManagerIdentifier)
    }
    
    public func responded(with response: SpecDialogManager.Response) {
    }
}
