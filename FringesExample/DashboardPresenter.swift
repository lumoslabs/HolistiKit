import UIKit

class DashboardPresenter: PushablePresenter {

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
    
    func push(on presenter: PushablePresenter) {
        let _viewController = viewControllerFactory.create(withPresenter: self)
        viewController = _viewController
        presenter.push(viewController: _viewController)
    }

    func push(viewController viewControllerToPush: ViewControlling) {
        viewController?.push(viewController: viewControllerToPush, animated: true)
    }

    func viewDidLoad() {
        viewController?.set(firstRowTitle: "Settings")
    }

    func tapFirstRow() {
        router.pushSettings(on: self)
    }
}
