import UIKit

class DateViewControllerFactory: DateViewControllerFactoryProtocol {
    
    func create(withPresenter presenter: DatePresenter) -> DateViewControlling {
        return DateViewController.create(presenter: presenter)
    }
}

extension DateViewController {

    static let storyboardName = "DateViewController"

    class func create(presenter: DatePresenter) -> DateViewController {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! DateViewController
        vc.presenter = presenter
        return vc
    }
}

protocol DateViewControllerFactoryProtocol {
    
    func create(withPresenter presenter: DatePresenter) -> DateViewControlling
}
