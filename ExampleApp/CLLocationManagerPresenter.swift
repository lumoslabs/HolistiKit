import UIKitFringes
import CoreLocation

class CLLocationManagerPresenter {
    
    fileprivate weak var viewController: CLLocationManagerViewController!

    func set(viewController: CLLocationManagerViewController) {
        self.viewController = viewController
    }

    func set(title text: String) {
        viewController.set(title: text)
    }

    func set(authorizationStatus: CLAuthorizationStatus) {
        viewController.set(authorizationStatus: String(describing: authorizationStatus))
    }
}
