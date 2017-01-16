import UIKit

class DashboardPresenter {

    private let viewControllerFactory: DashboardViewControllingFactoryProtocol
    fileprivate let interactor: DashboardInteractor
    fileprivate let router: DashboardRouter
    fileprivate let dataSource = DashboardDataSource()
    fileprivate let errorLogger: ErrorLogging
    fileprivate weak var viewController: DashboardViewControlling?

    init(viewControllerFactory: DashboardViewControllingFactoryProtocol,
         interactor: DashboardInteractor,
         router: DashboardRouter,
         errorLogger: ErrorLogging) {
        self.viewControllerFactory = viewControllerFactory
        self.interactor = interactor
        self.router = router
        self.errorLogger = errorLogger
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
            router.pushDate(on: self)
        case IndexPath(row: 1, section: 0):
            router.pushTimer(on: self)
        default:
            errorLogger.log("Tapping on a row (section: \(indexPath.section), row: \(indexPath.row)) that is not handled")
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
