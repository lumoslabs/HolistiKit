import UIKitFringes

class ExamplesNavigationPresenter: PushingPresenter {

    private let viewControllerFactory: ExamplesNavigationControllingFactoryProtocol
    private let router: ExamplesRouter
    private weak var viewController: ExamplesNavigationControlling?

    init(viewControllerFactory: ExamplesNavigationControllingFactoryProtocol,
         router: ExamplesRouter) {
        self.viewControllerFactory = viewControllerFactory
        self.router = router
    }

    func present(onWindow window: Windowing) {
        let _viewController = viewControllerFactory.create()
        viewController = _viewController
        router.pushExamples(on: self)
        window.set(rootViewController: _viewController)
    }

    func pushVC(_ viewControllerToPush: ViewControlling) {
        viewController?.push(viewController: viewControllerToPush, animated: false)
    }

    func push(_ presenter: Presenting) {
        let viewControllerToPush = presenter.viewControlling
        viewController?.push(viewController: viewControllerToPush, animated: false)
    }
}
