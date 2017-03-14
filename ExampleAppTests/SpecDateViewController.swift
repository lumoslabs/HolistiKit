import SpecUIKitFringes
@testable import ExampleApp

class SpecDateViewControllerFactory: DateViewControllerFactoryProtocol {

    func create(withInteractor interactor: DateInteractor) -> DateViewController {
        let viewController = SpecDateViewController()
        viewController.interactor = interactor
        return viewController
    }
}

protocol SpecDateViewControllerUI {

    var dateLabel: String? { get }
    var title: String? { get }
}

class SpecDateViewController: DateViewController, SpecDateViewControllerUI {

    private(set) var dateLabel: String?

    override func set(dateLabel text: String) {
        dateLabel = text
    }

    override func set(title text: String) {
        title = text
    }
}
