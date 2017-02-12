import UIKitFringes

class ExamplesNavigationPresenterFactory {

    let viewControllerFactory: ExamplesNavigationControllingFactoryProtocol

    init(viewControllerFactory: ExamplesNavigationControllingFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
    }

    func create(rootViewController: ViewControlling) -> ViewControlling {
        let presenter = ExamplesNavigationPresenter()
        let viewController = viewControllerFactory.create()
        presenter.set(viewController: viewController, rootViewController: rootViewController)
        return viewController
    }
}
