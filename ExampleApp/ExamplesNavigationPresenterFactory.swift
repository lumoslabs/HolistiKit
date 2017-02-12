import UIKitFringes

class ExamplesNavigationPresenterFactory {

    let viewControllerFactory: ExamplesNavigationControllingFactoryProtocol

    init(viewControllerFactory: ExamplesNavigationControllingFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
    }

    func create(withRouter router: ExamplesRouter) -> ViewControlling {
        let presenter = ExamplesNavigationPresenter(router: router)
        let viewController = viewControllerFactory.create()
        presenter.set(viewController: viewController)
        router.pushExamples(on: presenter)
        return viewController
    }
}
