import UIKit

class CLLocationManagerViewControllerFactory: CLLocationManagerViewControllerFactoryProtocol {

    func create(withInteractor interactor: CLLocationManagerInteractor) -> CLLocationManagerViewController {
        return CLLocationManagerViewController.create(interactor: interactor)
    }
}

extension CLLocationManagerViewController {

    static let storyboardName = "CLLocationManagerViewController"

    class func create(interactor: CLLocationManagerInteractor) -> CLLocationManagerViewController {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! CLLocationManagerViewController
        vc.interactor = interactor
        return vc
    }
}

protocol CLLocationManagerViewControllerFactoryProtocol {
    
    func create(withInteractor interactor: CLLocationManagerInteractor) -> CLLocationManagerViewController
}
