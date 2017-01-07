import UIKit

class DashboardViewControllingFactory: DashboardViewControllingFactoryProtocol {

    func create(withPresenter presenter: DashboardPresenter) -> DashboardViewControlling {
        let viewController = DashboardViewController()
        viewController.presenter = presenter
        return viewController
    }
}

protocol DashboardViewControllingFactoryProtocol {
    
    func create(withPresenter presenter: DashboardPresenter) -> DashboardViewControlling
}
