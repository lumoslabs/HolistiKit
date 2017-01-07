import UIKit

class DashboardViewController: UIViewController, DashboardViewControlling {

    var presenter: DashboardPresenter!

    func present(onWindow window: UIWindow) {
        window.rootViewController = self
    }

    func set(backgroundColor: UIColor) {
        self.view.backgroundColor = backgroundColor
    }
}

protocol DashboardViewControlling: class {

    func present(onWindow: UIWindow)
    func set(backgroundColor: UIColor)
}
