import CoreLocation

public class SpecLocationServices {

    weak var delegate: SpecLocationServicesDelegate?

    private var locationServicesDialogResponseCount = 0
    
    private(set) var enabled = true {
        didSet { delegate?.locationServicesEnabledDidChange() }
    }

    func respondedToLocationServicesDialog() {
        locationServicesDialogResponseCount += 1
    }

    func locationServices(enabled: Bool) {
        self.enabled = enabled
    }

    var canShowDialog: Bool {
        // iOS will only ever show the user this dialog twice for this app.
        // It only counts as being shown if the user responds. For example,
        // the following things can dismiss the dialog without it counting:
        // * Locking the device.
        // * Receiving a call, accepting, and then clicking Home.
        return locationServicesDialogResponseCount < 2
    }
}

protocol SpecLocationServicesDelegate: class {

    func locationServicesEnabledDidChange()
}
