import UIKit
@testable import FringesExample

class SpecDashboardViewControllingFactory: DashboardViewControllingFactoryProtocol {

    var viewController: SpecDashboardViewController!

    func create(withPresenter presenter: DashboardPresenter) -> DashboardViewControlling {
        viewController = SpecDashboardViewController(presenter: presenter)
        return viewController
    }
}

class SpecDashboardViewController: DashboardViewControlling {

    // Input
    // ...
    // Output
    private(set) var backgroundColor: UIColor?

    private let presenter: DashboardPresenter

    init(presenter: DashboardPresenter) {
        self.presenter = presenter
    }
    
    func present(onWindow: UIWindow) {
    }

    func set(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
    }
}
