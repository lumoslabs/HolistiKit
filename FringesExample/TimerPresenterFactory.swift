class TimerPresenterFactory {
    
    private let viewControllerFactory: TimerViewControllerFactoryProtocol
    private let dateProvider: DateProviding
    private let timeZoneProvider: TimeZoneProviding
    private let timerFactory: TimerFactoryProtocol
    
    init(viewControllerFactory: TimerViewControllerFactoryProtocol,
         dateProvider: DateProviding,
         timeZoneProvider: TimeZoneProviding,
         timerFactory: TimerFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
        self.dateProvider = dateProvider
        self.timeZoneProvider = timeZoneProvider
        self.timerFactory = timerFactory
    }
    
    func create(withRouter router: DashboardRouter) -> TimerPresenter {
        let interactor = TimerInteractor(dateProvider: dateProvider,
                                         timerFactory: timerFactory)
        let datePrinter = DatePrinter(timeZoneProvider: timeZoneProvider)
        return TimerPresenter(viewControllerFactory: viewControllerFactory,
                             interactor: interactor,
                             datePrinter: datePrinter)
    }
}
