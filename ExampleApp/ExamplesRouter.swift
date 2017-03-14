import UIKitFringes

class ExamplesRouter {

    private let examplesModuleFactory: ExamplesModuleFactory
    private let dateModuleFactory: DateModuleFactory
    private let timerModuleFactory: TimerModuleFactory
    private let urlSessionModuleFactory: URLSessionModuleFactory
    private let uiViewControllerModuleFactory: UIViewControllerModuleFactory
    private let clLocationManagerModuleFactory: CLLocationManagerModuleFactory

    init(examplesModuleFactory: ExamplesModuleFactory,
         timerModuleFactory: TimerModuleFactory,
         urlSessionModuleFactory: URLSessionModuleFactory,
         dateModuleFactory: DateModuleFactory,
         uiViewControllerModuleFactory: UIViewControllerModuleFactory,
         clLocationManagerModuleFactory: CLLocationManagerModuleFactory) {
        self.examplesModuleFactory = examplesModuleFactory
        self.timerModuleFactory = timerModuleFactory
        self.urlSessionModuleFactory = urlSessionModuleFactory
        self.dateModuleFactory = dateModuleFactory
        self.uiViewControllerModuleFactory = uiViewControllerModuleFactory
        self.clLocationManagerModuleFactory = clLocationManagerModuleFactory
    }

    func present(onWindow window: UIWindow) {
        let examplesViewController = examplesModuleFactory.create(withRouter: self)
        let examplesNavigationViewController = UINavigationController(rootViewController: examplesViewController)
        window.rootViewController = examplesNavigationViewController
    }

    enum ModuleIdentifier {
        case uiViewController
        case date
        case urlSession
        case timer
        case clLocationManager
    }

    enum SegueInfo {
        case present(PresentingPresenter)
        case push(PushingPresenter)
    }

    func navigate(to module: ModuleIdentifier, by segue: SegueInfo) {
        let vc = viewController(for: module)
        switch segue {
        case .present(let presenter): presenter.present(viewController: vc)
        case .push(let presenter): presenter.push(viewController: vc)
        }
    }

    private func viewController(for module: ModuleIdentifier) -> UIViewController {
        switch module {
        case .uiViewController: return uiViewControllerModuleFactory.create(withRouter: self)
        case .date: return dateModuleFactory.create()
        case .urlSession: return urlSessionModuleFactory.create()
        case .timer: return timerModuleFactory.create()
        case .clLocationManager: return clLocationManagerModuleFactory.create()
        }
    }
}

class ExamplesRouterFactory {
    
    private let examplesModuleFactory: ExamplesModuleFactory
    private let timerModuleFactory: TimerModuleFactory
    private let urlSessionModuleFactory: URLSessionModuleFactory
    private let dateModuleFactory: DateModuleFactory
    private let uiViewControllerModuleFactory: UIViewControllerModuleFactory
    private let clLocationManagerModuleFactory: CLLocationManagerModuleFactory

    init(examplesModuleFactory: ExamplesModuleFactory,
         timerModuleFactory: TimerModuleFactory,
         urlSessionModuleFactory: URLSessionModuleFactory,
         dateModuleFactory: DateModuleFactory,
         uiViewControllerModuleFactory: UIViewControllerModuleFactory,
         clLocationManagerModuleFactory: CLLocationManagerModuleFactory) {
        self.examplesModuleFactory = examplesModuleFactory
        self.timerModuleFactory = timerModuleFactory
        self.urlSessionModuleFactory = urlSessionModuleFactory
        self.dateModuleFactory = dateModuleFactory
        self.uiViewControllerModuleFactory = uiViewControllerModuleFactory
        self.clLocationManagerModuleFactory = clLocationManagerModuleFactory
    }

    func create() -> ExamplesRouter {
        return ExamplesRouter(examplesModuleFactory: examplesModuleFactory,
                              timerModuleFactory: timerModuleFactory,
                              urlSessionModuleFactory: urlSessionModuleFactory,
                              dateModuleFactory: dateModuleFactory,
                              uiViewControllerModuleFactory: uiViewControllerModuleFactory,
                              clLocationManagerModuleFactory: clLocationManagerModuleFactory)
    }
}
