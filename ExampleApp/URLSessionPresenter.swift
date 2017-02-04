import UIKit

class URLSessionPresenter {

    private let viewControllerFactory: URLSessionViewControllerFactoryProtocol
    fileprivate weak var viewController: URLSessionViewControlling!
    fileprivate let interactor: URLSessionInteractor
    fileprivate let errorLogger: ErrorLogging

    init(viewControllerFactory: URLSessionViewControllerFactoryProtocol,
         interactor: URLSessionInteractor,
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

extension URLSessionPresenter: URLSessionPresenting {

    func viewDidLoad() {
        viewController.set(title: "URLSession")
        viewController.set(data: "", animated: false)
        interactor.delegate = self
    }

    func didTap(rowAt indexPath: IndexPath) {
        switch indexPath {
        case IndexPath(row: 0, section: 0):
            interactor.request(.json)
        case IndexPath(row: 1, section: 0):
            interactor.request(.html)
        default:
            errorLogger.log("Tapping on a row (section: \(indexPath.section), row: \(indexPath.row)) that is not handled")
        }
    }
}

extension URLSessionPresenter: URLSessionInteractorDelegate {

    func received(json: [String : Any]) {
        let text = String(describing: json)
        viewController.set(data: text, animated: true)
    }

    func received(html: String) {
        viewController.set(data: html, animated: true)
    }
}

protocol URLSessionPresenting {

    func viewDidLoad()
    func didTap(rowAt indexPath: IndexPath)
}

protocol URLSessionInteractorDelegate: class {

    func received(json: [String : Any])
    func received(html: String)
}
