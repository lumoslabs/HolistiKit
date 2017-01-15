@testable import FringesExample

class SpecSettingsViewControllerFactory: SettingsViewControllerFactoryProtocol {
    
    func create(withPresenter presenter: SettingsPresenter) -> SettingsViewControlling {
        return SpecSettingsViewController(presenter: presenter)
    }
}

protocol SpecSettingsViewControllerUI {

    var dateLabel: String? { get }
}

class SpecSettingsViewController: SpecViewController, SettingsViewControlling, SpecSettingsViewControllerUI {

    private(set) var dateLabel: String?
    private let presenter: SettingsPresenting

    init(presenter: SettingsPresenting) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        presenter.viewDidLoad()
    }

    func set(dateLabel text: String) {
        dateLabel = text
    }
}
