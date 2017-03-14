import SpecUIKitFringes
import UIKitFringes
@testable import ExampleApp

class SpecUIViewControllerViewControllerFactory: UIViewControllerViewControllerFactoryProtocol {
    
    func create(withInteractor interactor: UIViewControllerInteractor) -> UIViewControllerViewController {
        let viewController = SpecUIViewControllerViewController()
        viewController.interactor = interactor
        return viewController
    }
}

protocol SpecUIViewControllerViewControllerUI {

    // Input
    func tapPresentViewController()
    // Output
    var title: String? { get }
    var presentedViewController: UIViewController? { get }
}

class SpecUIViewControllerViewController: UIViewControllerViewController, SpecUIViewControllerViewControllerUI {

    override func set(title text: String) {
        title = text
    }

    func tapPresentViewController() { tap(row: 0) }

    private func tap(row: Int) {
        let ip = indexPath(forRow: row)
        interactor.didTap(rowAt: ip)
    }

    private func indexPath(forRow row: Int) -> IndexPath {
        return IndexPath(row: row, section: 0)
    }
}
