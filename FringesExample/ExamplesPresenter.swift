import UIKit

class ExamplesPresenter {

    private let viewControllerFactory: ExamplesViewControllingFactoryProtocol
    fileprivate let interactor: ExamplesInteractor
    fileprivate let router: ExamplesRouter
    fileprivate let dataSource = ExamplesDataSource()
    fileprivate let errorLogger: ErrorLogging
    fileprivate weak var viewController: ExamplesViewControlling?

    init(viewControllerFactory: ExamplesViewControllingFactoryProtocol,
         interactor: ExamplesInteractor,
         router: ExamplesRouter,
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

extension ExamplesPresenter: PushablePresenter {

    func push(viewController viewControllerToPush: ViewControlling) {
        viewController?.push(viewController: viewControllerToPush, animated: true)
    }
}

extension ExamplesPresenter: ExamplesPresenting {

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
    
    func cellConfiguration(for indexPath: IndexPath) -> ExamplesCellConfig {
        return dataSource.cellConfiguration(for: indexPath)
    }

    var numberOfRows: Int {
        return dataSource.numberOfRows
    }
}

protocol ExamplesPresenting {
    
    func viewDidLoad()
    func tap(rowAt indexPath: IndexPath)
    func cellConfiguration(for: IndexPath) -> ExamplesCellConfig
    var numberOfRows: Int { get }
}
