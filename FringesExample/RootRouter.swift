import UIKit

class RootRouter {
    
    func present(onWindow window: UIWindow) {
        let dashboardRouter = DashboardRouter()
        dashboardRouter.present(onWindow: window)
    }
    
}
