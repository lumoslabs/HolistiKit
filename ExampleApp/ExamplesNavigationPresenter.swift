import UIKitFringes

class ExamplesNavigationPresenter {

    func set(viewController: NavigationControlling, rootViewController: ViewControlling) {
        viewController.push(viewController: rootViewController, animated: false)
    }
}
