import UIKit

class SettingsPresenter {

    private let viewControllerFactory: SettingsViewControllerFactoryProtocol
    fileprivate weak var viewController: SettingsViewControlling!

    init(viewControllerFactory: SettingsViewControllerFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
    }
    
    func push(on presenter: PushablePresenter) {
        let _viewController = viewControllerFactory.create(withPresenter: self)
        viewController = _viewController
        presenter.push(viewController: _viewController)
    }
}

extension SettingsPresenter: SettingsPresenting {
    
    func viewDidLoad() {
        viewController.set(dateLabel: "00:00 August 23rd, 2016")
    }
}

protocol SettingsPresenting {

    func viewDidLoad()
}
