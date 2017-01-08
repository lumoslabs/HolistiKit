@testable import FringesExample

class SpecSettingsViewControllerFactory: SettingsViewControllerFactoryProtocol {
    
    func create(withPresenter presenter: SettingsPresenter) -> SettingsViewControlling {
        return SpecSettingsViewController(presenter: presenter)
    }
}

protocol SpecSettingsViewControllerUI {
}

class SpecSettingsViewController: SpecViewController, SettingsViewControlling, SpecSettingsViewControllerUI {
    
    private let presenter: SettingsPresenter

    init(presenter: SettingsPresenter) {
        self.presenter = presenter
    }
}
