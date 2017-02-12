import UIKitFringes

class ExamplesPresenter {

    fileprivate let router: ExamplesRouter
    fileprivate weak var viewController: ExamplesViewControlling?

    init(router: ExamplesRouter) {
        self.router = router
    }

    func set(viewController: ExamplesViewControlling) {
        self.viewController = viewController
    }
    
    func set(title text: String) {
        viewController?.set(title: text)
    }

    func navigateToDate() {
        router.pushDate(on: self)
    }

    func navigateToTimer() {
        router.pushTimer(on: self)
    }

    func navigateToURLSession() {
        router.pushURLSession(on: self)
    }

    func navigateToUIViewController() {
        router.pushUIViewController(on: self)
    }
}

extension ExamplesPresenter: PushingPresenter {

    func pushVC(_ viewControlling: ViewControlling) {
        viewController?.navigationControlling?.push(viewController: viewControlling, animated: true)
    }

    func push(_ presenter: Presenting) {
        let viewControllerToPush = presenter.viewControlling
        viewController?.navigationControlling?.push(viewController: viewControllerToPush, animated: true)
    }
}
