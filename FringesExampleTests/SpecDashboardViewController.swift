import UIKit
@testable import FringesExample

class SpecDashboardViewControllingFactory: DashboardViewControllingFactoryProtocol {

    func create(withPresenter presenter: DashboardPresenter) -> DashboardViewControlling {
        return SpecDashboardViewController(presenter: presenter)
    }
}

protocol SpecDashboardViewControllerUI {
    
    // Input
    func tapSettingsRow()
    // Output
    var title: String? { get }
    var numberOfRows: Int { get }
    func title(forRow: Int) -> String
}

class SpecDashboardViewController: SpecViewController, DashboardViewControlling, SpecDashboardViewControllerUI {
    
    private(set) var title: String?
    private let presenter: DashboardPresenting

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
    
    func title(forRow row: Int) -> String {
        let ip = indexPath(forRow: row)
        let config = presenter.cellConfiguration(for: ip)
        return config.title
    }

    private func tap(row: Int) {
        let ip = indexPath(forRow: row)
        presenter.tap(rowAt: ip)
    }

    func tapSettingsRow() {
        tap(row: 0)
    }

    var numberOfRows: Int {
        return presenter.numberOfRows
    }

    private func indexPath(forRow row: Int) -> IndexPath {
        return IndexPath(row: row, section: 0)
    }
}