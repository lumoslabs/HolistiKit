class TimerPresenterFactory {
    
    private let viewControllerFactory: TimerViewControllerFactoryProtocol
    private let dateProvider: DateProviding
    private let timeZoneProvider: TimeZoneProviding
    
    init(viewControllerFactory: TimerViewControllerFactoryProtocol,
         dateProvider: DateProviding,
         timeZoneProvider: TimeZoneProviding) {
        self.viewControllerFactory = viewControllerFactory
        self.dateProvider = dateProvider
        self.timeZoneProvider = timeZoneProvider
    }
    
    func create(withRouter router: DashboardRouter) -> TimerPresenter {
        let interactor = TimerInteractor(dateProvider: dateProvider)
        let datePrinter = DatePrinter(timeZoneProvider: timeZoneProvider)
        return TimerPresenter(viewControllerFactory: viewControllerFactory,
                             interactor: interactor,
                             datePrinter: datePrinter)
    }
}
