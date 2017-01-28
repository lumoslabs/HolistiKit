import UIKit

class NetworkRequestPresenter {

    private let viewControllerFactory: NetworkRequestViewControllerFactoryProtocol
    fileprivate weak var viewController: NetworkRequestViewControlling!
    fileprivate let interactor: NetworkRequestInteractor

    init(viewControllerFactory: NetworkRequestViewControllerFactoryProtocol,
         interactor: NetworkRequestInteractor) {
        self.viewControllerFactory = viewControllerFactory
        self.interactor = interactor
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
        viewController.set(data: "")
        interactor.delegate = self
    }
}

extension NetworkRequestPresenter: NetworkRequestInteractorDelegate {

    func received(data: [String : Any]) {
        viewController.set(data: String(describing: data))
    }
}

protocol NetworkRequestPresenting {

    func viewDidLoad()
}

protocol NetworkRequestInteractorDelegate: class {

    func received(data: [String : Any])
}
