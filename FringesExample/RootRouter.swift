import UIKitFringes

class RootRouter {

    private let examplesRouter: ExamplesRouter

    init(examplesNavigationPresenterFactory: ExamplesNavigationPresenterFactory,
         examplesPresenterFactory: ExamplesPresenterFactory,
         timerPresenterFactory: TimerPresenterFactory,
         networkRequestPresenterFactory: NetworkRequestPresenterFactory,
         datePresenterFactory: DatePresenterFactory,
         uiViewControllerPresenterFactory: UIViewControllerPresenterFactory) {
        self.examplesRouter = ExamplesRouter(examplesNavigationPresenterFactory: examplesNavigationPresenterFactory,
                                             examplesPresenterFactory: examplesPresenterFactory,
                                             timerPresenterFactory: timerPresenterFactory,
                                             networkRequestPresenterFactory: networkRequestPresenterFactory,
                                             datePresenterFactory: datePresenterFactory,
                                             uiViewControllerPresenterFactory: uiViewControllerPresenterFactory)
    }

    func present(onWindow window: Windowing) {
        examplesRouter.present(onWindow: window)
    }
}
