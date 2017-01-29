import UIKitFringes

class UIViewControllerPresenter: UIViewControllerPresenting {
    
    private let viewControllerFactory: UIViewControllerViewControllerFactoryProtocol
    fileprivate weak var viewController: UIViewControllerViewControlling!
    fileprivate let router: ExamplesRouter
    fileprivate let errorLogger: ErrorLogging

    init(viewControllerFactory: UIViewControllerViewControllerFactoryProtocol,
         router: ExamplesRouter,
         errorLogger: ErrorLogging) {
        self.viewControllerFactory = viewControllerFactory
        self.router = router
        self.errorLogger = errorLogger
    }
    
    func push(on presenter: PushablePresenter) {
        let _viewController = viewControllerFactory.create(withPresenter: self)
        viewController = _viewController
        presenter.push(viewController: _viewController)
    }
    
    func present(on presenter: PresentablePresenter) {
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

extension UIViewControllerPresenter: PresentablePresenter {

    func present(viewController viewControllerToPresent: ViewControlling) {
        viewController?.present(viewController: viewControllerToPresent)
    }
}

protocol UIViewControllerPresenting {

    func viewDidLoad()
    func didTap(rowAt indexPath: IndexPath)
}
