import UIKit
@testable import FringesExample

class SpecDashboardViewControllingFactory: DashboardViewControllingFactoryProtocol {

    private(set) var viewController: SpecDashboardViewControllerUI!

    func create(withPresenter presenter: DashboardPresenter) -> DashboardViewControlling {
        let _viewController = SpecDashboardViewController(presenter: presenter)
        viewController = _viewController
        return _viewController
    }
}

protocol SpecDashboardViewControllerUI {
    
    // Input
    func tapOnAddToCountButton()
    // Output
    var countLabel: String? { get }
    var backgroundColor: UIColor? { get }
}

class SpecDashboardViewController: DashboardViewControlling, SpecDashboardViewControllerUI {

    private(set) var backgroundColor: UIColor?
    private(set) var countLabel: String?

    private let presenter: DashboardPresenter

    init(presenter: DashboardPresenter) {
        self.presenter = presenter
    }
    
    func present(onWindow: UIWindow) {
        presenter.viewDidLoad()
    }

    func set(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
    }
    
    func tapOnAddToCountButton() {
        presenter.tapOnAddToCountButton()
    }

    func set(countLabel: String) {
        self.countLabel = countLabel
    }
}
