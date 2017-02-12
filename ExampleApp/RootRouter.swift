import UIKitFringes

class RootRouter {

    private let examplesRouter: ExamplesRouter

    init(examplesNavigationModuleFactory: ExamplesNavigationModuleFactory,
         examplesModuleFactory: ExamplesModuleFactory,
         timerModuleFactory: TimerModuleFactory,
         urlSessionModuleFactory: URLSessionModuleFactory,
         dateModuleFactory: DateModuleFactory,
         uiViewControllerModuleFactory: UIViewControllerModuleFactory) {
        self.examplesRouter = ExamplesRouter(examplesNavigationModuleFactory: examplesNavigationModuleFactory,
                                             examplesModuleFactory: examplesModuleFactory,
                                             timerModuleFactory: timerModuleFactory,
                                             urlSessionModuleFactory: urlSessionModuleFactory,
                                             dateModuleFactory: dateModuleFactory,
                                             uiViewControllerModuleFactory: uiViewControllerModuleFactory)
    }

    func present(onWindow window: Windowing) {
        examplesRouter.present(onWindow: window)
    }
}
