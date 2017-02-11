import UIKitFringes

class ExamplesPresenter {

    fileprivate let viewControllerFactory: ExamplesViewControllingFactoryProtocol
    fileprivate let router: ExamplesRouter
    fileprivate let dataSource = ExamplesDataSource()
    fileprivate let errorLogger: ErrorLogging
    fileprivate weak var viewController: ExamplesViewControlling?

    init(viewControllerFactory: ExamplesViewControllingFactoryProtocol,
         router: ExamplesRouter,
         errorLogger: ErrorLogging) {
        self.viewControllerFactory = viewControllerFactory
        self.router = router
        self.errorLogger = errorLogger
    }
}

extension ExamplesPresenter: Presenting {
    
    var viewControlling: ViewControlling {
        if let viewController = viewController { return viewController }
        let _viewController = viewControllerFactory.create(withPresenter: self)
        viewController = _viewController
        return _viewController
    }
}

extension ExamplesPresenter: PushingPresenter {

    func push(_ presenter: Presenting) {
        let viewControllerToPush = presenter.viewControlling
        viewController?.navigationControlling?.push(viewController: viewControllerToPush, animated: true)
    }
}

extension ExamplesPresenter: ExamplesPresenting {

    func viewDidLoad() {
        viewController?.set(title: "Examples")
    }

    func tap(rowAt indexPath: IndexPath) {
        let presenterToPush: ExamplesRouter.PresenterIdentifier
        switch indexPath {
        case IndexPath(row: 0, section: 0): presenterToPush = .date
        case IndexPath(row: 1, section: 0): presenterToPush = .timer
        case IndexPath(row: 2, section: 0): presenterToPush = .urlSession
        case IndexPath(row: 3, section: 0): presenterToPush = .uiViewController
        default:
            errorLogger.log("Tapping on a row (section: \(indexPath.section), row: \(indexPath.row)) that is not handled")
            presenterToPush = .date
        }
        router.push(presenterToPush, on: self)
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
