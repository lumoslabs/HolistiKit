import UIKitFringes

class ExamplesRouter {

    private let examplesPresenterFactory: ExamplesPresenterFactory
    private let datePresenterFactory: DatePresenterFactory
    private let timerPresenterFactory: TimerPresenterFactory
    private let urlSessionPresenterFactory: URLSessionPresenterFactory
    private let examplesNavigationPresenterFactory: ExamplesNavigationPresenterFactory
    private let uiViewControllerPresenterFactory: UIViewControllerPresenterFactory

    init(examplesNavigationPresenterFactory: ExamplesNavigationPresenterFactory,
         examplesPresenterFactory: ExamplesPresenterFactory,
         timerPresenterFactory: TimerPresenterFactory,
         urlSessionPresenterFactory: URLSessionPresenterFactory,
         datePresenterFactory: DatePresenterFactory,
         uiViewControllerPresenterFactory: UIViewControllerPresenterFactory) {
        self.examplesNavigationPresenterFactory = examplesNavigationPresenterFactory
        self.examplesPresenterFactory = examplesPresenterFactory
        self.timerPresenterFactory = timerPresenterFactory
        self.urlSessionPresenterFactory = urlSessionPresenterFactory
        self.datePresenterFactory = datePresenterFactory
        self.uiViewControllerPresenterFactory = uiViewControllerPresenterFactory
    }
    
    func present(onWindow window: Windowing) {
        let examplesNavigationPresenter = examplesNavigationPresenterFactory.create(withRouter: self)
        examplesNavigationPresenter.present(onWindow: window)
    }

    enum PresenterIdentifier {
        case examples
        case urlSession
        case uiViewController
    }

    func pushTimer(on pushingPresenter: ExamplesPresenter) {
        let pushedViewController = timerPresenterFactory.create(withRouter: self)
        pushingPresenter.pushVC(pushedViewController)
    }

    func pushDate(on pushingPresenter: ExamplesPresenter) {
        let pushedViewController = datePresenterFactory.create(withRouter: self)
        pushingPresenter.pushVC(pushedViewController)
    }

    private func presenter(for presenterIdentifier: PresenterIdentifier) -> Presenting {
        switch presenterIdentifier {
        case .examples:
            return examplesPresenterFactory.create(withRouter: self)
        case .urlSession:
            return urlSessionPresenterFactory.create(withRouter: self)
        case .uiViewController:
            return uiViewControllerPresenterFactory.create(withRouter: self)
        }
    }

    func push(_ presenterIdentifier: PresenterIdentifier, on pushingPresenter: PushingPresenter) {
        let pushedPresenter = presenter(for: presenterIdentifier)
        pushingPresenter.push(pushedPresenter)
    }
    
    func presentUIViewController(on presenter: PresentingPresenter) {
        let uiViewControllerPresenter = uiViewControllerPresenterFactory.create(withRouter: self)
        uiViewControllerPresenter.present(on: presenter)
    }
}
