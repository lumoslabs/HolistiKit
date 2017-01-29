class UIViewControllerPresenter: UIViewControllerPresenting {
    
    private let viewControllerFactory: UIViewControllerViewControllerFactoryProtocol
    fileprivate weak var viewController: UIViewControllerViewControlling!

    init(viewControllerFactory: UIViewControllerViewControllerFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
    }
    
    func push(on presenter: PushablePresenter) {
        let _viewController = viewControllerFactory.create(withPresenter: self)
        viewController = _viewController
        presenter.push(viewController: _viewController)
    }

    func viewDidLoad() {
        viewController.set(title: "UIViewController")
    }
}

protocol UIViewControllerPresenting {

    func viewDidLoad()
}
