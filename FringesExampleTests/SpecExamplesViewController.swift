import UIKit
@testable import FringesExample

class SpecExamplesViewControllingFactory: ExamplesViewControllingFactoryProtocol {

    func create(withPresenter presenter: ExamplesPresenter) -> ExamplesViewControlling {
        return SpecExamplesViewController(presenter: presenter)
    }
}

protocol SpecExamplesViewControllerUI {
    
    // Input
    func tapDateRow()
    func tapTimerRow()
    // Output
    var title: String? { get }
    var numberOfRows: Int { get }
    func title(forRow: Int) -> String
    func accessoryIndicator(forRow: Int) -> UITableViewCellAccessoryType
}

class SpecExamplesViewController: SpecViewController, ExamplesViewControlling, SpecExamplesViewControllerUI {
    
    private(set) var title: String?
    private let presenter: ExamplesPresenting

    init(presenter: ExamplesPresenter) {
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
        return cellConfiguration(forRow: row).title
    }

    func accessoryIndicator(forRow row: Int) -> UITableViewCellAccessoryType {
        return cellConfiguration(forRow: row).accessoryType
    }

    private func cellConfiguration(forRow row: Int) -> ExamplesCellConfig {
        let ip = indexPath(forRow: row)
        return presenter.cellConfiguration(for: ip)
    }

    private func tap(row: Int) {
        if row >= numberOfRows { fatalError("Tapping on a non-existent row") }
        let ip = indexPath(forRow: row)
        presenter.tap(rowAt: ip)
    }

    func tapDateRow() {
        tap(row: 0)
    }

    func tapTimerRow() {
        tap(row: 1)
    }

    var numberOfRows: Int {
        return presenter.numberOfRows
    }

    private func indexPath(forRow row: Int) -> IndexPath {
        return IndexPath(row: row, section: 0)
    }
}
