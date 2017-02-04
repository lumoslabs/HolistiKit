import UIKit

class URLSessionViewControllerFactory: URLSessionViewControllerFactoryProtocol {

    func create(withPresenter presenter: URLSessionPresenter) -> URLSessionViewControlling {
        return URLSessionViewController.create(presenter: presenter)
    }
}

extension URLSessionViewController {

    static let storyboardName = "URLSessionViewController"

    class func create(presenter: URLSessionPresenter) -> URLSessionViewController {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! URLSessionViewController
        vc.presenter = presenter
        return vc
    }
}

protocol URLSessionViewControllerFactoryProtocol {

    func create(withPresenter presenter: URLSessionPresenter) -> URLSessionViewControlling
}
