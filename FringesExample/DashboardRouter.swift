import UIKit

class DashboardRouter {
    
    private let dashboardPresenter: DashboardPresenter

    init(dashboardPresenter: DashboardPresenter) {
        self.dashboardPresenter = dashboardPresenter
    }
    
    func present(onWindow window: UIWindow) {
        dashboardPresenter.present(onWindow: window)
    }
}
