import UIKit

class DashboardRouter {
    
    func present(onWindow window: UIWindow) {
        let dashboardPresenter = DashboardPresenter()
        dashboardPresenter.present(onWindow: window)
    }
    
}
