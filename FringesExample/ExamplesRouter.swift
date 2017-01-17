class ExamplesRouter {

    private let examplesPresenterFactory: ExamplesPresenterFactory
    private let datePresenterFactory: DatePresenterFactory
    private let timerPresenterFactory: TimerPresenterFactory
    private let examplesNavigationPresenterFactory: ExamplesNavigationPresenterFactory

    init(examplesNavigationPresenterFactory: ExamplesNavigationPresenterFactory,
         examplesPresenterFactory: ExamplesPresenterFactory,
         timerPresenterFactory: TimerPresenterFactory,
         datePresenterFactory: DatePresenterFactory) {
        self.examplesNavigationPresenterFactory = examplesNavigationPresenterFactory
        self.examplesPresenterFactory = examplesPresenterFactory
        self.timerPresenterFactory = timerPresenterFactory
        self.datePresenterFactory = datePresenterFactory
    }
    
    func present(onWindow window: Windowing) {
        let examplesNavigationPresenter = examplesNavigationPresenterFactory.create(withRouter: self)
        examplesNavigationPresenter.present(onWindow: window)
    }

    func pushExamples(on presenter: PushablePresenter) {
        let examplesPresenter = examplesPresenterFactory.create(withRouter: self)
        examplesPresenter.push(on: presenter)
    }
    
    func pushDate(on presenter: PushablePresenter) {
        let datePresenter = datePresenterFactory.create(withRouter: self)
        datePresenter.push(on: presenter)
    }
    
    func pushTimer(on presenter: PushablePresenter) {
        let timerPresenter = timerPresenterFactory.create(withRouter: self)
        timerPresenter.push(on: presenter)
    }
}
