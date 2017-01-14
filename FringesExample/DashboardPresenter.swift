import UIKit

class DashboardPresenter {

    private let viewControllerFactory: DashboardViewControllingFactoryProtocol
    private let interactor: DashboardInteractor
    private let router: DashboardRouter
    private weak var viewController: DashboardViewControlling?

    init(viewControllerFactory: DashboardViewControllingFactoryProtocol,
         interactor: DashboardInteractor,
         router: DashboardRouter) {
        self.viewControllerFactory = viewControllerFactory
        self.interactor = interactor
        self.router = router
        interactor.set(presenter: self)
    }
    
    func push(on presenter: DashboardNavigationPresenter) {
        let _viewController = viewControllerFactory.create(withPresenter: self)
        viewController = _viewController
        presenter.push(viewController: _viewController)
    }

    func push(settingsPresenter: SettingsPresenter) {
        let settingsViewController = settingsPresenter.viewController!
        viewController?.push(viewController: settingsViewController, animated: true)
    }

    func viewDidLoad() {
        viewController?.set(firstRowTitle: "Settings")
    }

    func tapFirstRow() {
        router.pushSettings(onPresenter: self)
    }
}
