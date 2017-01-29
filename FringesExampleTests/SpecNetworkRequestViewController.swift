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
    func tapRequestHTML()
    // Output
    var title: String? { get }
    var dataLabel: SpecNetworkRequestViewController.DataLabel? { get }
}

class SpecNetworkRequestViewController: SpecViewController, NetworkRequestViewControlling, SpecNetworkRequestViewControllerUI {

    private(set) var title: String?
    private(set) var dataLabel: DataLabel?
    private let presenter: NetworkRequestPresenting

    struct DataLabel {
        let text: String
        let animated: Bool
    }

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

    func tapRequestHTML() {
        tap(row: 1)
    }

    func set(title text: String) {
        title = text
    }

    func set(data text: String, animated: Bool) {
        dataLabel = DataLabel(text: text, animated: animated)
    }

    private func tap(row: Int) {
        let ip = indexPath(forRow: row)
        presenter.didTap(rowAt: ip)
    }

    private func indexPath(forRow row: Int) -> IndexPath {
        return IndexPath(row: row, section: 0)
    }
}

extension SpecNetworkRequestViewController.DataLabel: Equatable { }
func ==(lhs: SpecNetworkRequestViewController.DataLabel, rhs: SpecNetworkRequestViewController.DataLabel) -> Bool {
    return lhs.text == rhs.text &&
        lhs.animated == rhs.animated
}
