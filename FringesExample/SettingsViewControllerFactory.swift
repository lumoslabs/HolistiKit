import UIKit

class SettingsViewControllerFactory: SettingsViewControllerFactoryProtocol {
    
    func create(withPresenter presenter: SettingsPresenter) -> SettingsViewControlling {
        return SettingsViewController.create(presenter: presenter)
    }
}

extension SettingsViewController {

    static let storyboardName = "SettingsViewController"

    class func create(presenter: SettingsPresenter) -> SettingsViewController {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! SettingsViewController
        vc.presenter = presenter
        return vc
    }
}

protocol SettingsViewControllerFactoryProtocol {
    
    func create(withPresenter presenter: SettingsPresenter) -> SettingsViewControlling
}
