import UIKit

class SettingsPresenter {

    private let viewControllerFactory: SettingsViewControllerFactoryProtocol
    var viewController: SettingsViewControlling!

    init(viewControllerFactory: SettingsViewControllerFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
    }
    
    func present(onPresenter presenter: DashboardPresenter) {
        let _viewController = viewControllerFactory.create(withPresenter: self)
        viewController = _viewController
        presenter.present(settingsPresenter: self)
    }
}
