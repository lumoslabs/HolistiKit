import UIKit

class RootRouter {

    private let dashboardRouter: DashboardRouter

    init(dashboardRouter: DashboardRouter) {
        self.dashboardRouter = dashboardRouter
    }
    
    func present(onWindow window: UIWindow) {
        dashboardRouter.present(onWindow: window)
    }
}
