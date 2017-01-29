import UIKitFringes

class RootRouter {

    private let examplesRouter: ExamplesRouter

    init(examplesNavigationPresenterFactory: ExamplesNavigationPresenterFactory,
         examplesPresenterFactory: ExamplesPresenterFactory,
         timerPresenterFactory: TimerPresenterFactory,
         urlSessionPresenterFactory: URLSessionPresenterFactory,
         datePresenterFactory: DatePresenterFactory,
         uiViewControllerPresenterFactory: UIViewControllerPresenterFactory) {
        self.examplesRouter = ExamplesRouter(examplesNavigationPresenterFactory: examplesNavigationPresenterFactory,
                                             examplesPresenterFactory: examplesPresenterFactory,
                                             timerPresenterFactory: timerPresenterFactory,
                                             urlSessionPresenterFactory: urlSessionPresenterFactory,
                                             datePresenterFactory: datePresenterFactory,
                                             uiViewControllerPresenterFactory: uiViewControllerPresenterFactory)
    }

    func present(onWindow window: Windowing) {
        examplesRouter.present(onWindow: window)
    }
}
