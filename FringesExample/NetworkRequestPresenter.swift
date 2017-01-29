import UIKit

class NetworkRequestPresenter {

    private let viewControllerFactory: NetworkRequestViewControllerFactoryProtocol
    fileprivate weak var viewController: NetworkRequestViewControlling!
    fileprivate let interactor: NetworkRequestInteractor
    fileprivate let errorLogger: ErrorLogging

    init(viewControllerFactory: NetworkRequestViewControllerFactoryProtocol,
         interactor: NetworkRequestInteractor,
         errorLogger: ErrorLogging) {
        self.viewControllerFactory = viewControllerFactory
        self.interactor = interactor
        self.errorLogger = errorLogger
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
        viewController.set(data: "", animated: false)
        interactor.delegate = self
    }

    func didTap(rowAt indexPath: IndexPath) {
        switch indexPath {
        case IndexPath(row: 0, section: 0):
            interactor.requestJSON()
        default:
            errorLogger.log("Tapping on a row (section: \(indexPath.section), row: \(indexPath.row)) that is not handled")
        }
    }
}

extension NetworkRequestPresenter: NetworkRequestInteractorDelegate {

    func received(data: [String : Any]) {
        let text = String(describing: data)
        viewController.set(data: text, animated: true)
    }
}

protocol NetworkRequestPresenting {

    func viewDidLoad()
    func didTap(rowAt indexPath: IndexPath)
}

protocol NetworkRequestInteractorDelegate: class {

    func received(data: [String : Any])
}
