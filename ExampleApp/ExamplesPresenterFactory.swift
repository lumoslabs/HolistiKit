import UIKitFringes

class ExamplesPresenterFactory {

    private let viewControllerFactory: ExamplesViewControllingFactoryProtocol
    private let errorLogger: ErrorLogging

    init(viewControllerFactory: ExamplesViewControllingFactoryProtocol,
         errorLogger: ErrorLogging) {
        self.viewControllerFactory = viewControllerFactory
        self.errorLogger = errorLogger
    }

    func create(withRouter router: ExamplesRouter) -> ViewControlling {
        let presenter = ExamplesPresenter(router: router)
        let interactor = ExamplesInteractor(presenter: presenter,
                                            errorLogger: errorLogger)
        let viewController = viewControllerFactory.create(withInteractor: interactor)
        presenter.set(viewController: viewController)
        return viewController
    }
}
