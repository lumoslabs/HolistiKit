import SpecUIKitFringes
import UIKitFringes
@testable import ExampleApp

class SpecCLLocationManagerViewControllerFactory: CLLocationManagerViewControllerFactoryProtocol {
    
    func create(withInteractor interactor: CLLocationManagerInteractor) -> CLLocationManagerViewController {
        let viewController = SpecCLLocationManagerViewController()
        viewController.interactor = interactor
        return viewController
    }
}

protocol SpecCLLocationManagerViewControllerUI {

    // Input
    func tapRequestAuthorizationRow()
    // Output
    var title: String? { get }
    var authorizationStatus: String? { get }
}

class SpecCLLocationManagerViewController: CLLocationManagerViewController, SpecCLLocationManagerViewControllerUI {

    private(set) var authorizationStatus: String?

    func tapRequestAuthorizationRow() {
        interactor.didTap(rowAt: IndexPath(row: 0, section: 1))
    }

    override func set(authorizationStatus text: String) {
        authorizationStatus = text
    }
}
