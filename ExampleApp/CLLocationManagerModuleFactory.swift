import UIKitFringes

class CLLocationManagerModuleFactory {

    private let viewControllerFactory: CLLocationManagerViewControllerFactoryProtocol
    private let locationManager: LocationManaging
    private let errorLogger: ErrorLogging

    init(viewControllerFactory: CLLocationManagerViewControllerFactoryProtocol,
         locationManager: LocationManaging,
         errorLogger: ErrorLogging) {
        self.viewControllerFactory = viewControllerFactory
        self.locationManager = locationManager
        self.errorLogger = errorLogger
    }

    func create() -> ViewControlling {
        let presenter = CLLocationManagerPresenter()
        let interactor = CLLocationManagerInteractor(presenter: presenter,
                                                     locationManager: locationManager,
                                                     errorLogger: errorLogger)
        let viewController = viewControllerFactory.create(withInteractor: interactor)
        presenter.set(viewController: viewController)
        return viewController
    }
}
