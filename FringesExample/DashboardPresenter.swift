import UIKit

class DashboardPresenter {

    private let viewControllerFactory: DashboardViewControllingFactoryProtocol
    fileprivate let interactor: DashboardInteractor
    fileprivate let router: DashboardRouter
    fileprivate let dataSource = DashboardDataSource()
    fileprivate weak var viewController: DashboardViewControlling?

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
}

extension DashboardPresenter: PushablePresenter {

    func push(viewController viewControllerToPush: ViewControlling) {
        viewController?.push(viewController: viewControllerToPush, animated: true)
    }
}

extension DashboardPresenter: DashboardPresenting {

    func viewDidLoad() {
        viewController?.set(title: "Examples")
    }

    func tap(rowAt indexPath: IndexPath) {
        switch indexPath {
        case IndexPath(row: 0, section: 0):
            router.pushSettings(on: self)
        default:
            break
        }
    }
    
    func cellConfiguration(for indexPath: IndexPath) -> DashboardCellConfig {
        return dataSource.cellConfiguration(for: indexPath)
    }

    var numberOfRows: Int {
        return dataSource.numberOfRows
    }
}

protocol DashboardPresenting {
    
    func viewDidLoad()
    func tap(rowAt indexPath: IndexPath)
    func cellConfiguration(for: IndexPath) -> DashboardCellConfig
    var numberOfRows: Int { get }
}
