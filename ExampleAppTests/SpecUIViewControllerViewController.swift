import SpecUIKitFringes
import UIKitFringes
@testable import ExampleApp

class SpecUIViewControllerViewControllerFactory: UIViewControllerViewControllerFactoryProtocol {
    
    func create(withPresenter presenter: UIViewControllerPresenter) -> UIViewControllerViewControlling {
        return SpecUIViewControllerViewController(presenter: presenter)
    }
}

protocol SpecUIViewControllerViewControllerUI {

    // Input
    func tapPresentViewController()
    // Output
    var title: String? { get }
    var presentedViewControlling: ViewControlling? { get }
}

class SpecUIViewControllerViewController: SpecViewController, UIViewControllerViewControlling, SpecUIViewControllerViewControllerUI {

    private(set) var title: String?
    private let presenter: UIViewControllerPresenting

    init(presenter: UIViewControllerPresenting) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        presenter.viewDidLoad()
    }

    func set(title text: String) {
        title = text
    }

    func tapPresentViewController() { tap(row: 0) }

    private func tap(row: Int) {
        let ip = indexPath(forRow: row)
        presenter.didTap(rowAt: ip)
    }

    private func indexPath(forRow row: Int) -> IndexPath {
        return IndexPath(row: row, section: 0)
    }
}
