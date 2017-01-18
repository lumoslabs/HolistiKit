import UIKit

class NetworkRequestViewControllerFactory: NetworkRequestViewControllerFactoryProtocol {

    func create(withPresenter presenter: NetworkRequestPresenter) -> NetworkRequestViewControlling {
        return NetworkRequestViewController.create(presenter: presenter)
    }
}

extension NetworkRequestViewController {

    static let storyboardName = "NetworkRequestViewController"

    class func create(presenter: NetworkRequestPresenter) -> NetworkRequestViewController {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! NetworkRequestViewController
        vc.presenter = presenter
        return vc
    }
}

protocol NetworkRequestViewControllerFactoryProtocol {
    
    func create(withPresenter presenter: NetworkRequestPresenter) -> NetworkRequestViewControlling
}
