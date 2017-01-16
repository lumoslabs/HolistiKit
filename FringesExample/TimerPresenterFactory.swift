class TimerPresenterFactory {
    
    private let viewControllerFactory: TimerViewControllerFactoryProtocol
    
    init(viewControllerFactory: TimerViewControllerFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
    }
    
    func create(withRouter router: DashboardRouter) -> TimerPresenter {
        return TimerPresenter(viewControllerFactory: viewControllerFactory)
    }
}
