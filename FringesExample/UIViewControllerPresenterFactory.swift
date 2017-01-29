class UIViewControllerPresenterFactory {

    private let viewControllerFactory: UIViewControllerViewControllerFactoryProtocol
    
    init(viewControllerFactory: UIViewControllerViewControllerFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
    }

    func create(withRouter router: ExamplesRouter) -> UIViewControllerPresenter {
        return UIViewControllerPresenter(viewControllerFactory: viewControllerFactory)
    }
}
