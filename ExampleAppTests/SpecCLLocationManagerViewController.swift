import SpecUIKitFringes
import UIKitFringes
@testable import ExampleApp

class SpecCLLocationManagerViewControllerFactory: CLLocationManagerViewControllerFactoryProtocol {
    
    func create(withInteractor interactor: CLLocationManagerInteractor) -> CLLocationManagerViewControlling {
        return SpecCLLocationManagerViewController(interactor: interactor)
    }
}

protocol SpecCLLocationManagerViewControllerUI {

    // Output
    var title: String? { get }
}

class SpecCLLocationManagerViewController: SpecViewController, CLLocationManagerViewControlling, SpecCLLocationManagerViewControllerUI {

    private(set) var title: String?
    private let interactor: CLLocationManagerInteractor

    init(interactor: CLLocationManagerInteractor) {
        self.interactor = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
    }

    func set(title text: String) {
        title = text
    }
}
