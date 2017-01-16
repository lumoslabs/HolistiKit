@testable import FringesExample

class SpecTimerViewControllerFactory: TimerViewControllerFactoryProtocol {
    
    func create(withPresenter presenter: TimerPresenter) -> TimerViewControlling {
        return SpecTimerViewController(presenter: presenter)
    }
}

protocol SpecTimerViewControllerUI {

    var title: String? { get }
}

class SpecTimerViewController: SpecViewController, TimerViewControlling, SpecTimerViewControllerUI {

    private(set) var title: String?
    private let presenter: TimerPresenting

    init(presenter: TimerPresenting) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        presenter.viewDidLoad()
    }

    func set(title text: String) {
        title = text
    }
}
