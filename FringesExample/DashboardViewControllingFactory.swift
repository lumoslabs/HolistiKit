import UIKit

class DashboardViewControllingFactory: DashboardViewControllingFactoryProtocol {

    func create(withPresenter presenter: DashboardPresenter) -> DashboardViewControlling {
        let viewController = DashboardViewController.create(presenter: presenter)
        return viewController
    }
}

extension DashboardViewController {

    static let storyboardName = "DashboardViewController"

    class func create(presenter: DashboardPresenter) -> DashboardViewController {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! DashboardViewController
        vc.presenter = presenter
        return vc
    }
}

protocol DashboardViewControllingFactoryProtocol {
    
    func create(withPresenter presenter: DashboardPresenter) -> DashboardViewControlling
}
