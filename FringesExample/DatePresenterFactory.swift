class DatePresenterFactory {
    
    private let viewControllerFactory: DateViewControllerFactoryProtocol
    private let dateProvider: DateProviding
    private let timeZoneProvider: TimeZoneProviding

    init(viewControllerFactory: DateViewControllerFactoryProtocol,
         dateProvider: DateProviding,
         timeZoneProvider: TimeZoneProviding) {
        self.viewControllerFactory = viewControllerFactory
        self.dateProvider = dateProvider
        self.timeZoneProvider = timeZoneProvider
    }

    func create(withRouter router: DashboardRouter) -> DatePresenter {
        let interactor = DateInteractor(dateProvider: dateProvider)
        let datePrinter = DatePrinter(timeZoneProvider: timeZoneProvider)
        return DatePresenter(viewControllerFactory: viewControllerFactory,
                                 interactor: interactor,
                                 datePrinter: datePrinter)
    }
}
