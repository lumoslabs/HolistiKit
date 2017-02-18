import Foundation

public class SystemDialog {

    public init() { }

    public enum LocationManagerIdentifier {
        // "Allow "<AppName>" to access your location while you use the app?"
        // "<message you have set in Info.plist for NSLocationWhenInUseUsageDescription>"
        // [Don't Allow] [Allow]
        case requestAccessWhileInUse
        // When status is notDetermined:
        // "Allow "<AppName>" to access your location even when you are not using the app?"
        // "<message you have set in Info.plist for NSLocationAlwaysUsageDescription>"
        // [Don't Allow] [Allow]
        // When status is already authorizedWhenInUse:
        // "Allow "<AppName>" to also access your location even when you are not using the app?"
        // "<message you have set in Info.plist for NSLocationAlwaysUsageDescription>"
        // [Cancel] [Allow]
        case requestAccessAlways
        // "Turn On Location Services to Allow "<AppName>" to Determine Your Location"
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
