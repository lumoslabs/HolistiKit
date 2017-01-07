import UIKit

class DashboardViewControllingFactory {

    func createAndPresent(onWindow window: UIWindow) -> DashboardViewControlling {
        let viewController = DashboardViewController()
        window.rootViewController = viewController
        return viewController
    }

}
