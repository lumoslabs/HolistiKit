import UIKitFringes

class ExamplesPresenter {

    fileprivate let router: ExamplesRouter
    fileprivate weak var viewController: ExamplesViewController?

    init(router: ExamplesRouter) {
        self.router = router
    }

    func set(viewController: ExamplesViewController) {
        self.viewController = viewController
    }
    
    func set(title text: String) {
        viewController?.set(title: text)
    }

    func push(_ module: ExamplesRouter.ModuleIdentifier) {
        router.navigate(to: module, by: .push(self))
    }
}

extension ExamplesPresenter: PushingPresenter {

    func push(viewController: UIViewController) {
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
