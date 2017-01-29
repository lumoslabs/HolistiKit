import SpecUIKitFringes
@testable import FringesExample

class SpecUIViewControllerViewControllerFactory: UIViewControllerViewControllerFactoryProtocol {
    
    func create(withPresenter presenter: UIViewControllerPresenter) -> UIViewControllerViewControlling {
        return SpecUIViewControllerViewController(presenter: presenter)
    }
}

protocol SpecUIViewControllerViewControllerUI {

    // Output
    var title: String? { get }
}

class SpecUIViewControllerViewController: SpecViewController, UIViewControllerViewControlling, SpecUIViewControllerViewControllerUI {

    private(set) var title: String?
    private let presenter: UIViewControllerPresenting

    init(presenter: UIViewControllerPresenting) {
        self.presenter = presenter
    }

    func set(title text: String) {
        title = text
    }

    override func viewDidLoad() {
        presenter.viewDidLoad()
    }
}
