import UIKit
@testable import FringesExample

class SpecDashboardViewControllingFactory: DashboardViewControllingFactoryProtocol {

    func create(withPresenter presenter: DashboardPresenter) -> DashboardViewControlling {
        return SpecDashboardViewController(presenter: presenter)
    }
}

protocol SpecDashboardViewControllerUI {
    
    // Input
    func tap(row: Int)
    // Output
    var title: String? { get }
    var firstRowTitle: String? { get }
}

class SpecDashboardViewController: SpecViewController, DashboardViewControlling, SpecDashboardViewControllerUI {
    
    private(set) var title: String?
    private(set) var firstRowTitle: String?

    private let presenter: DashboardPresenter

    init(presenter: DashboardPresenter) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    func set(title text: String) {
        title = text
    }

    func set(firstRowTitle text: String) {
        firstRowTitle = text
    }

    func tap(row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        presenter.tap(rowAt: indexPath)
    }
}
