import UIKit
@testable import FringesExample

class SpecDashboardNavigationControllingFactory: DashboardNavigationControllingFactoryProtocol {

    func create() -> DashboardNavigationControlling {
        return SpecDashboardNavigationController()
    }
}

protocol SpecDashboardNavigationControllerUI: SpecNavigationControllerUI {
}

class SpecDashboardNavigationController: SpecNavigationController, DashboardNavigationControlling, SpecDashboardNavigationControllerUI {
}
