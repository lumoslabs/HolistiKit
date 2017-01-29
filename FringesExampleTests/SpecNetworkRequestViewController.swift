import SpecUIKitFringes
@testable import FringesExample

class SpecURLSessionViewControllerFactory: URLSessionViewControllerFactoryProtocol {
    
    func create(withPresenter presenter: URLSessionPresenter) -> URLSessionViewControlling {
        return SpecURLSessionViewController(presenter: presenter)
    }
}

protocol SpecURLSessionViewControllerUI {

    // Input
    func tapRequestJSON()
    func tapRequestHTML()
    // Output
    var title: String? { get }
    var dataLabel: SpecURLSessionViewController.DataLabel? { get }
}

class SpecURLSessionViewController: SpecViewController, URLSessionViewControlling, SpecURLSessionViewControllerUI {

    private(set) var title: String?
    private(set) var dataLabel: DataLabel?
    private let presenter: URLSessionPresenting

    struct DataLabel {
        let text: String
        let animated: Bool
    }

    init(presenter: URLSessionPresenting) {
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

extension SpecURLSessionViewController.DataLabel: Equatable { }
func ==(lhs: SpecURLSessionViewController.DataLabel, rhs: SpecURLSessionViewController.DataLabel) -> Bool {
    return lhs.text == rhs.text &&
        lhs.animated == rhs.animated
}
