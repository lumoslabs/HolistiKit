import Foundation

class SystemDialog {

    enum LocationManagerIdentifier {
        case requestAccessWhileInUse
    }

    enum DialogIdentifier {
        case locationManager(LocationManagerIdentifier)
    }

    private var dialogs = [DialogIdentifier]()
    
    func addDialog(withIdentifier identifier: DialogIdentifier) {
        dialogs.append(identifier)
    }

    var visibleDialog: DialogIdentifier? {
        return dialogs.first
    }
}

extension SystemDialog.DialogIdentifier: Equatable {}
func ==(lhs: SystemDialog.DialogIdentifier, rhs: SystemDialog.DialogIdentifier) -> Bool {
    switch (lhs, rhs) {
        case (.locationManager(let subL), .locationManager(let subR)):
            return subL == subR
    }
}
