class SettingsPresenterFactory {
    
    let viewControllerFactory: SettingsViewControllerFactoryProtocol

    init(viewControllerFactory: SettingsViewControllerFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
    }

    func create(withRouter router: RootRouter) -> SettingsPresenter {
        return SettingsPresenter(viewControllerFactory: viewControllerFactory)
    }
}
