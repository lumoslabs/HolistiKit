@testable import FringesExample

class SpecNetworkRequestViewControllerFactory: NetworkRequestViewControllerFactoryProtocol {
    
    func create(withPresenter presenter: NetworkRequestPresenter) -> NetworkRequestViewControlling {
        return SpecNetworkRequestViewController(presenter: presenter)
    }
}

protocol SpecNetworkRequestViewControllerUI {
    
    var title: String? { get }
    var dataLabel: String? { get }
}

class SpecNetworkRequestViewController: SpecViewController, NetworkRequestViewControlling, SpecNetworkRequestViewControllerUI {

    private(set) var title: String?
    private(set) var dataLabel: String?
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

    func set(data text: String) {
        dataLabel = text
    }
}
