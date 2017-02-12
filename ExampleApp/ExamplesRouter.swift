import UIKitFringes

class ExamplesRouter {

    private let examplesModuleFactory: ExamplesModuleFactory
    private let dateModuleFactory: DateModuleFactory
    private let timerModuleFactory: TimerModuleFactory
    private let urlSessionModuleFactory: URLSessionModuleFactory
    private let examplesNavigationModuleFactory: ExamplesNavigationModuleFactory
    private let uiViewControllerModuleFactory: UIViewControllerModuleFactory

    init(examplesNavigationModuleFactory: ExamplesNavigationModuleFactory,
         examplesModuleFactory: ExamplesModuleFactory,
         timerModuleFactory: TimerModuleFactory,
         urlSessionModuleFactory: URLSessionModuleFactory,
         dateModuleFactory: DateModuleFactory,
         uiViewControllerModuleFactory: UIViewControllerModuleFactory) {
        self.examplesNavigationModuleFactory = examplesNavigationModuleFactory
        self.examplesModuleFactory = examplesModuleFactory
        self.timerModuleFactory = timerModuleFactory
        self.urlSessionModuleFactory = urlSessionModuleFactory
        self.dateModuleFactory = dateModuleFactory
        self.uiViewControllerModuleFactory = uiViewControllerModuleFactory
    }

    func present(onWindow window: Windowing) {
        let examplesViewController = examplesModuleFactory.create(withRouter: self)
        let examplesNavigationViewController = examplesNavigationModuleFactory.create(rootViewController: examplesViewController)
        window.set(rootViewController: examplesNavigationViewController)
    }

    enum ModuleIdentifier {
        case uiViewController
        case date
        case urlSession
        case timer
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

    private func viewController(for module: ModuleIdentifier) -> ViewControlling {
        switch module {
        case .uiViewController: return uiViewControllerModuleFactory.create(withRouter: self)
        case .date: return dateModuleFactory.create(withRouter: self)
        case .urlSession: return urlSessionModuleFactory.create(withRouter: self)
        case .timer: return timerModuleFactory.create(withRouter: self)
        }
    }
}
