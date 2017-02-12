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
        router.navigate(to: .date, by: .push(self))
    }

    func navigateToTimer() {
        router.navigate(to: .timer, by: .push(self))
    }

    func navigateToURLSession() {
        router.navigate(to: .urlSession, by: .push(self))
    }

    func navigateToUIViewController() {
        router.navigate(to: .uiViewController, by: .push(self))
    }
}

extension ExamplesPresenter: PushingPresenter {

    func push(viewController: ViewControlling) {
        self.viewController?.navigationControlling?.push(viewController: viewController, animated: true)
    }
}
