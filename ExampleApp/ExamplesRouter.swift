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

    func pushTimer(on pushingPresenter: ExamplesPresenter) {
        let pushedViewController = timerModuleFactory.create(withRouter: self)
        pushingPresenter.push(pushedViewController)
    }

    func pushURLSession(on pushingPresenter: ExamplesPresenter) {
        let pushedViewController = urlSessionModuleFactory.create(withRouter: self)
        pushingPresenter.push(pushedViewController)
    }
    
    func pushUIViewController(on pushingPresenter: ExamplesPresenter) {
        let pushedViewController = uiViewControllerModuleFactory.create(withRouter: self)
        pushingPresenter.push(pushedViewController)
    }

    func pushDate(on pushingPresenter: ExamplesPresenter) {
        let pushedViewController = dateModuleFactory.create(withRouter: self)
        pushingPresenter.push(pushedViewController)
    }

    func presentUIViewController(on presenter: PresentingPresenter) {
        let uiViewControllerPresenter = uiViewControllerModuleFactory.create(withRouter: self)
        presenter.present(viewController: uiViewControllerPresenter)
    }
}
