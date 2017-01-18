import UIKit

class NetworkRequestPresenter {

    private let viewControllerFactory: NetworkRequestViewControllerFactoryProtocol
    fileprivate weak var viewController: NetworkRequestViewControlling!

    init(viewControllerFactory: NetworkRequestViewControllerFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
    }
    
    func push(on presenter: PushablePresenter) {
        let _viewController = viewControllerFactory.create(withPresenter: self)
        viewController = _viewController
        presenter.push(viewController: _viewController)
    }
}

extension NetworkRequestPresenter: NetworkRequestPresenting {

    func viewDidLoad() {
        viewController.set(title: "Network Request")
    }
}

protocol NetworkRequestPresenting {

    func viewDidLoad()
}
