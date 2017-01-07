import UIKit

class DashboardViewController: UIViewController, DashboardViewControlling {

    func set(backgroundColor: UIColor) {
        self.view.backgroundColor = backgroundColor
    }
}

protocol DashboardViewControlling {

    func set(backgroundColor: UIColor)
}
