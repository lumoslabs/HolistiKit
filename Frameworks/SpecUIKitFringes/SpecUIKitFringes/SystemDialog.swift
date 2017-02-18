import Foundation

public class SystemDialog {

    public init() { }

    public enum LocationManagerIdentifier {
        // "Allow "TransitApp" to access your location while you use the app?"
        // "<message you have set in Info.plist for NSLocationWhenInUseUsageDescription>"
        // [Don't Allow] [Allow]
        case requestAccessWhileInUse
        // Similar to the one above, but with different messaging.
        case requestAccessAlways
        // "Turn On Location Services to Allow "TransitApp" to Determine Your Location"
        // [Settings] [Cancel]
        case requestJumpToLocationServicesSettings
    }

    public enum DialogIdentifier {
        case locationManager(LocationManagerIdentifier)
    }

    public var visibleDialog: DialogIdentifier? {
        return dialogs.first
    }

    private var dialogs = [DialogIdentifier]()
    
    func addDialog(withIdentifier identifier: DialogIdentifier) {
        dialogs.append(identifier)
    }

    @discardableResult
    func popDialog() -> DialogIdentifier? {
        if dialogs.isEmpty { return nil }
        return dialogs.remove(at: 0)
    }
}

extension SystemDialog.DialogIdentifier: Equatable {}
public func ==(lhs: SystemDialog.DialogIdentifier, rhs: SystemDialog.DialogIdentifier) -> Bool {
    switch (lhs, rhs) {
        case (.locationManager(let subL), .locationManager(let subR)):
            return subL == subR
    }
}
