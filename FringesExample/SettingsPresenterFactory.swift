class SettingsPresenterFactory {
    
    private let viewControllerFactory: SettingsViewControllerFactoryProtocol
    private let dateProvider: DateProviding
    private let timeZoneProvider: TimeZoneProviding

    init(viewControllerFactory: SettingsViewControllerFactoryProtocol,
         dateProvider: DateProviding,
         timeZoneProvider: TimeZoneProviding) {
        self.viewControllerFactory = viewControllerFactory
        self.dateProvider = dateProvider
        self.timeZoneProvider = timeZoneProvider
    }

    func create(withRouter router: DashboardRouter) -> SettingsPresenter {
        let interactor = SettingsInteractor(dateProvider: dateProvider)
        let datePrinter = DatePrinter(timeZoneProvider: timeZoneProvider)
        return SettingsPresenter(viewControllerFactory: viewControllerFactory,
                                 interactor: interactor,
                                 datePrinter: datePrinter)
    }
}
