import SpecUIKitFringes
@testable import ExampleApp

class SpecTimerViewControllerFactory: TimerViewControllerFactoryProtocol {

    func create(withInteractor interactor: TimerInteractor) -> TimerViewController {
        let viewController = SpecTimerViewController()
        viewController.interactor = interactor
        return viewController
    }
}

protocol SpecTimerViewControllerUI {

    var title: String? { get }
    var dateLabel: String? { get }
}

class SpecTimerViewController: TimerViewController, SpecTimerViewControllerUI {

    private(set) var dateLabel: String?

    override func set(dateLabel text: String) {
        dateLabel = text
    }
}
