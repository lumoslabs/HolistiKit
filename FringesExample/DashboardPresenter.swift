import UIKit

class DashboardPresenter {

    private let viewControllerFactory: DashboardViewControllingFactoryProtocol
    private let interactor: DashboardInteractor
    private var router: RootRouter!
    private weak var viewController: DashboardViewControlling?

    func set(router: RootRouter) {
        self.router = router
    }

    init(viewControllerFactory: DashboardViewControllingFactoryProtocol,
         interactor: DashboardInteractor) {
        self.viewControllerFactory = viewControllerFactory
        self.interactor = interactor
        interactor.set(presenter: self)
    }

    func present(onWindow window: Windowing) {
        let _viewController = viewControllerFactory.create(withPresenter: self)
        viewController = _viewController
        _viewController.present(onWindow: window)
    }

    func present(settingsPresenter: SettingsPresenter) {
        let settingsViewController = settingsPresenter.viewController!
        viewController?.present(viewController: settingsViewController)
    }

    func viewDidLoad() {
        viewController?.set(backgroundColor: UIColor.green)
        set(countLabel: "Never tapped before")
    }

    func tapOnAddToCountButton() {
        interactor.tapOnAddToCountButton()
    }
    
    func tapOnSettingsButton() {
        router.presentSettingsPage(onPresenter: self)
    }

    func set(count: Int) {
        let times = count == 1 ? "time" : "times"
        let text = "tapped \(count) \(times)"
        set(countLabel: text)
    }

    private func set(countLabel: String) {
        viewController?.set(countLabel: countLabel)
    }
}
