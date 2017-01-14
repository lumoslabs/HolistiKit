import UIKit

class SettingsPresenter {

    private let viewControllerFactory: SettingsViewControllerFactoryProtocol
    weak var viewController: SettingsViewControlling!

    init(viewControllerFactory: SettingsViewControllerFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
    }
    
    func push(on presenter: PushablePresenter) {
        let _viewController = viewControllerFactory.create(withPresenter: self)
        viewController = _viewController
        presenter.push(viewController: _viewController)
    }
}
