import UIKitFringes

class ExamplesNavigationPresenter: PushingPresenter {

    private let router: ExamplesRouter
    private weak var viewController: ExamplesNavigationControlling?

    init(router: ExamplesRouter) {
        self.router = router
    }

    func set(viewController: ExamplesNavigationControlling) {
        self.viewController = viewController
    }

    func push(_ viewControllerToPush: ViewControlling) {
        viewController?.push(viewController: viewControllerToPush, animated: false)
    }
}
