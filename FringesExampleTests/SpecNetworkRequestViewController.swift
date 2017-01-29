import SpecUIKitFringes
@testable import FringesExample

class SpecNetworkRequestViewControllerFactory: NetworkRequestViewControllerFactoryProtocol {
    
    func create(withPresenter presenter: NetworkRequestPresenter) -> NetworkRequestViewControlling {
        return SpecNetworkRequestViewController(presenter: presenter)
    }
}

protocol SpecNetworkRequestViewControllerUI {

    // Input
    func tapRequestJSON()
    // Output
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
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    func tapRequestJSON() {
        tap(row: 0)
    }

    func set(title text: String) {
        title = text
    }

    func set(data text: String) {
        dataLabel = text
    }

    private func tap(row: Int) {
        let ip = indexPath(forRow: row)
        presenter.didTap(rowAt: ip)
    }

    private func indexPath(forRow row: Int) -> IndexPath {
        return IndexPath(row: row, section: 0)
    }
}
