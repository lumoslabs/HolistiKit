import UIKit

class DashboardCoordinator {

    func present(onWindow window: UIWindow) {
        let viewController = DashboardViewController()
        window.rootViewController = viewController
    }
    
}
