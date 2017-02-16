import UIKitFringes

class CLLocationManagerModuleFactory {

    private let viewControllerFactory: CLLocationManagerViewControllerFactoryProtocol
    private let locationManager: LocationManaging

    init(viewControllerFactory: CLLocationManagerViewControllerFactoryProtocol,
         locationManager: LocationManaging) {
        self.viewControllerFactory = viewControllerFactory
        self.locationManager = locationManager
    }

    func create() -> ViewControlling {
        let presenter = CLLocationManagerPresenter()
        let interactor = CLLocationManagerInteractor(presenter: presenter,
                                                     locationManager: locationManager)
        let viewController = viewControllerFactory.create(withInteractor: interactor)
        presenter.set(viewController: viewController)
        return viewController
    }
}
