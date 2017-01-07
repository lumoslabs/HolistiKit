import UIKit

class DashboardPresenter {

    private let viewControllerFactory: DashboardViewControllingFactoryProtocol
    private let interactor: DashboardInteractor
    private weak var viewController: DashboardViewControlling?

    init(viewControllerFactory: DashboardViewControllingFactoryProtocol,
         interactor: DashboardInteractor) {
        self.viewControllerFactory = viewControllerFactory
        self.interactor = interactor
        interactor.set(presenter: self)
    }

    func present(onWindow window: UIWindow) {
        let _viewController = viewControllerFactory.create(withPresenter: self)
        viewController = _viewController
        _viewController.present(onWindow: window)
    }

    func viewDidLoad() {
        viewController?.set(backgroundColor: UIColor.green)
        set(countLabel: "Never tapped before")
    }

    func tapOnAddToCountButton() {
        interactor.tapOnAddToCountButton()
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
