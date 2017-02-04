import UIKit

class UIViewControllerViewControllerFactory: UIViewControllerViewControllerFactoryProtocol {

    func create(withPresenter presenter: UIViewControllerPresenter) -> UIViewControllerViewControlling {
        return UIViewControllerViewController.create(presenter: presenter)
    }
}

extension UIViewControllerViewController {

    static let storyboardName = "UIViewControllerViewController"

    class func create(presenter: UIViewControllerPresenter) -> UIViewControllerViewController {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! UIViewControllerViewController
        vc.presenter = presenter
        return vc
    }
}

protocol UIViewControllerViewControllerFactoryProtocol {
    
    func create(withPresenter presenter: UIViewControllerPresenter) -> UIViewControllerViewControlling
}
