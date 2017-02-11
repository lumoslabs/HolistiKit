import UIKitFringes

class UIViewControllerPresenter: UIViewControllerPresenting {
    
    fileprivate let viewControllerFactory: UIViewControllerViewControllerFactoryProtocol
    fileprivate let router: ExamplesRouter
    fileprivate let errorLogger: ErrorLogging
    fileprivate weak var viewController: UIViewControllerViewControlling!

    init(viewControllerFactory: UIViewControllerViewControllerFactoryProtocol,
         router: ExamplesRouter,
         errorLogger: ErrorLogging) {
        self.viewControllerFactory = viewControllerFactory
        self.router = router
        self.errorLogger = errorLogger
    }

    func present(on presenter: PresentingPresenter) {
        let _viewController = viewControllerFactory.create(withPresenter: self)
        viewController = _viewController
        presenter.present(viewController: _viewController)
    }

    func viewDidLoad() {
        viewController.set(title: "UIViewController")
    }
    
    func didTap(rowAt indexPath: IndexPath) {
        switch indexPath {
        case IndexPath(row: 0, section: 0):
            router.presentUIViewController(on: self)
        default:
            errorLogger.log("Tapping on a row (section: \(indexPath.section), row: \(indexPath.row)) that is not handled")
        }
    }
}

extension UIViewControllerPresenter: Presenting {

    var viewControlling: ViewControlling {
        if let viewController = viewController { return viewController }
        let _viewController = viewControllerFactory.create(withPresenter: self)
        viewController = _viewController
        return _viewController
    }
}

extension UIViewControllerPresenter: PresentingPresenter {

    func present(viewController viewControllerToPresent: ViewControlling) {
        viewController?.present(viewController: viewControllerToPresent)
    }
}

protocol UIViewControllerPresenting {

    func viewDidLoad()
    func didTap(rowAt indexPath: IndexPath)
}
