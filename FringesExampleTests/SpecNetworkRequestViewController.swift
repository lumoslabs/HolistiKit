@testable import FringesExample

class SpecNetworkRequestViewControllerFactory: NetworkRequestViewControllerFactoryProtocol {
    
    func create(withPresenter presenter: NetworkRequestPresenter) -> NetworkRequestViewControlling {
        return SpecNetworkRequestViewController(presenter: presenter)
    }
}

protocol SpecNetworkRequestViewControllerUI {
    
    var title: String? { get }
}

class SpecNetworkRequestViewController: SpecViewController, NetworkRequestViewControlling, SpecNetworkRequestViewControllerUI {

    private(set) var title: String?
    private(set) var dateLabel: String?
    private let presenter: NetworkRequestPresenting

    init(presenter: NetworkRequestPresenting) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        presenter.viewDidLoad()
    }

    func set(title text: String) {
        title = text
    }
}
