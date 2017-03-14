import UIKitFringes

class UIViewControllerPresenter {
    
    fileprivate let router: ExamplesRouter
    fileprivate weak var viewController: UIViewControllerViewController!

    init(router: ExamplesRouter) {
        self.router = router
    }

    func set(viewController: UIViewControllerViewController) {
        self.viewController = viewController
    }
    
    func set(title text: String) {
        viewController.set(title: text)
    }

    func presentUIViewController() {
        router.navigate(to: .uiViewController, by: .present(self))
    }
}

extension UIViewControllerPresenter: PresentingPresenter {

    func present(viewController: UIViewController) {
        self.viewController?.present(viewController, animated: true)
    }
}
