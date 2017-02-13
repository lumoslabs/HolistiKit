import UIKitFringes

class CLLocationManagerModuleFactory {

    private let viewControllerFactory: CLLocationManagerViewControllerFactoryProtocol

    init(viewControllerFactory: CLLocationManagerViewControllerFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
    }

    func create() -> ViewControlling {
        let presenter = CLLocationManagerPresenter()
        let interactor = CLLocationManagerInteractor(presenter: presenter)
        let viewController = viewControllerFactory.create(withInteractor: interactor)
        presenter.set(viewController: viewController)
        return viewController
    }
}
