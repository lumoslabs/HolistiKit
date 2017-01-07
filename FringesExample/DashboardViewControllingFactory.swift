import UIKit

class DashboardViewControllingFactory: DashboardViewControllingFactoryProtocol {

    func createAndPresent(onWindow window: UIWindow) -> DashboardViewControlling {
        let viewController = DashboardViewController()
        window.rootViewController = viewController
        return viewController
    }
}

protocol DashboardViewControllingFactoryProtocol {
    
    func createAndPresent(onWindow window: UIWindow) -> DashboardViewControlling
}
