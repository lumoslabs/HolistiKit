import UIKit

class DashboardPresenter {

    func present(onWindow window: UIWindow) {
        let viewController = DashboardViewController()
        window.rootViewController = viewController
    }
    
}
