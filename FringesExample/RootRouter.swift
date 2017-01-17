class RootRouter {

    private let examplesRouter: ExamplesRouter

    init(examplesNavigationPresenterFactory: ExamplesNavigationPresenterFactory,
         examplesPresenterFactory: ExamplesPresenterFactory,
         timerPresenterFactory: TimerPresenterFactory,
         datePresenterFactory: DatePresenterFactory) {
        self.examplesRouter = ExamplesRouter(examplesNavigationPresenterFactory: examplesNavigationPresenterFactory,
                                               examplesPresenterFactory: examplesPresenterFactory,
                                               timerPresenterFactory: timerPresenterFactory,
                                               datePresenterFactory: datePresenterFactory)
    }
    
    func present(onWindow window: Windowing) {
        examplesRouter.present(onWindow: window)
    }
}
