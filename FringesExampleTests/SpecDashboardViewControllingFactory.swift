import UIKit
@testable import FringesExample

class SpecDashboardViewControllingFactory: DashboardViewControllingFactoryProtocol {

    var dashboardViewController: SpecDashboardViewController!

    func createAndPresent(onWindow window: UIWindow) -> DashboardViewControlling {
        dashboardViewController = SpecDashboardViewController()
        return dashboardViewController
    }
}

class SpecDashboardViewController: DashboardViewControlling {

    var backgroundColor: UIColor?

    func set(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
    }
}
