class DashboardPresenterFactory {

    private let viewControllerFactory: DashboardViewControllingFactoryProtocol
    private let errorLogger: ErrorLogging

    init(viewControllerFactory: DashboardViewControllingFactoryProtocol,
         errorLogger: ErrorLogging) {
        self.viewControllerFactory = viewControllerFactory
        self.errorLogger = errorLogger
    }

    func create(withRouter router: DashboardRouter) -> DashboardPresenter {
        let interactor = DashboardInteractor()
        return DashboardPresenter(viewControllerFactory: viewControllerFactory,
                                  interactor: interactor,
                                  router: router,
                                  errorLogger: errorLogger)
    }

}
