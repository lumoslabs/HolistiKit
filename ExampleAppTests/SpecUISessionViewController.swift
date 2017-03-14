import SpecUIKitFringes
@testable import ExampleApp

class SpecURLSessionViewControllerFactory: URLSessionViewControllerFactoryProtocol {
    
    func create(withInteractor interactor: URLSessionInteractor) -> URLSessionViewController {
        let viewController = SpecURLSessionViewController()
        viewController.interactor = interactor
        return viewController
    }
}

protocol SpecURLSessionViewControllerUI {

    // Input
    func tapRequestJSON()
    func tapRequestHTML()
    // Output
    var title: String? { get }
    var dataLabel: SpecURLSessionViewController.DataLabel? { get }
}

class SpecURLSessionViewController: URLSessionViewController, SpecURLSessionViewControllerUI {

    private(set) var dataLabel: DataLabel?

    struct DataLabel {
        let text: String
        let animated: Bool
    }

    func tapRequestJSON() { tap(row: 0) }
    func tapRequestHTML() { tap(row: 1) }

    override func set(data text: String, animated: Bool) {
        dataLabel = DataLabel(text: text, animated: animated)
    }

    private func tap(row: Int) {
        let ip = indexPath(forRow: row)
        interactor.didTap(rowAt: ip)
    }

    private func indexPath(forRow row: Int) -> IndexPath {
        return IndexPath(row: row, section: 0)
    }
}

extension SpecURLSessionViewController.DataLabel: Equatable { }
func ==(lhs: SpecURLSessionViewController.DataLabel, rhs: SpecURLSessionViewController.DataLabel) -> Bool {
    return lhs.text == rhs.text &&
        lhs.animated == rhs.animated
}
