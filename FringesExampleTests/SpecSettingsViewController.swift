@testable import FringesExample

class SpecSettingsViewControllerFactory: SettingsViewControllerFactoryProtocol {

    private(set) var viewController: SpecSettingsViewControllerUI!
    
    func create(withPresenter presenter: SettingsPresenter) -> SettingsViewControlling {
        let _viewController = SpecSettingsViewController(presenter: presenter)
        viewController = _viewController
        return _viewController
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
