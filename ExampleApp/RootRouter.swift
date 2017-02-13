import UIKitFringes

class RootRouter {

    private let examplesRouter: ExamplesRouter

    // TODO inject an ExamplesRouterFactory instead
    init(examplesNavigationModuleFactory: ExamplesNavigationModuleFactory,
         examplesModuleFactory: ExamplesModuleFactory,
         timerModuleFactory: TimerModuleFactory,
         urlSessionModuleFactory: URLSessionModuleFactory,
         dateModuleFactory: DateModuleFactory,
         uiViewControllerModuleFactory: UIViewControllerModuleFactory,
         clLocationManagerModuleFactory: CLLocationManagerModuleFactory) {
        self.examplesRouter = ExamplesRouter(examplesNavigationModuleFactory: examplesNavigationModuleFactory,
                                             examplesModuleFactory: examplesModuleFactory,
                                             timerModuleFactory: timerModuleFactory,
                                             urlSessionModuleFactory: urlSessionModuleFactory,
                                             dateModuleFactory: dateModuleFactory,
                                             uiViewControllerModuleFactory: uiViewControllerModuleFactory,
                                             clLocationManagerModuleFactory: clLocationManagerModuleFactory)
    }

    func present(onWindow window: Windowing) {
        examplesRouter.present(onWindow: window)
    }
}
