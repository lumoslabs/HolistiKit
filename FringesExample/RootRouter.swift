import UIKit

class RootRouter {

    private let dashboardPresenter: DashboardPresenter
    private let settingsPresenter: SettingsPresenter

    init(dashboardPresenter: DashboardPresenter,
         settingsPresenter: SettingsPresenter) {
        self.dashboardPresenter = dashboardPresenter
        self.settingsPresenter = settingsPresenter
    }
    
    func present(onWindow window: UIWindow) {
        dashboardPresenter.present(onWindow: window)
    }
    
    func presentSettingsPage(onPresenter presenter: DashboardPresenter) {
        settingsPresenter.present(onPresenter: presenter)
    }
}
