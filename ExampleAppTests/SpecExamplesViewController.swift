import SpecUIKitFringes
import UIKit
@testable import ExampleApp

class SpecExamplesViewControllerFactory: ExamplesViewControllerFactoryProtocol {

    func create(withInteractor interactor: ExamplesInteractor) -> ExamplesViewController {
        let viewController = SpecExamplesViewController()
        viewController.interactor = interactor
        return viewController
    }
}

protocol SpecExamplesViewControllerUI {
    
    // Input
    func tapDateRow()
    func tapTimerRow()
    func tapURLSessionRow()
    func tapUIViewControllerRow()
    func tapCLLocationManagerRow()
    // Output
    var title: String? { get }
    var numberOfRows: Int { get }
    func title(forRow: Int) -> String
    func accessoryIndicator(forRow: Int) -> UITableViewCellAccessoryType
}

class SpecExamplesViewController: ExamplesViewController, SpecExamplesViewControllerUI {

    func title(forRow row: Int) -> String {
        return cellConfiguration(forRow: row).title
    }

    func accessoryIndicator(forRow row: Int) -> UITableViewCellAccessoryType {
        return cellConfiguration(forRow: row).accessoryType
    }

    func tapDateRow() { tap(row: 0) }
    func tapTimerRow() { tap(row: 1) }
    func tapURLSessionRow() { tap(row: 2) }
    func tapUIViewControllerRow() { tap(row: 3) }
    func tapCLLocationManagerRow() { tap(row: 4) }
    
    var numberOfRows: Int {
        return interactor.numberOfRows
    }

    private func indexPath(forRow row: Int) -> IndexPath {
        return IndexPath(row: row, section: 0)
    }

    private func cellConfiguration(forRow row: Int) -> ExamplesCellConfig {
        let ip = indexPath(forRow: row)
        return interactor.cellConfiguration(for: ip)
    }

    private func tap(row: Int) {
        if row >= numberOfRows { fatalError("Tapping on a non-existent row") }
        let ip = indexPath(forRow: row)
        interactor.tap(rowAt: ip)
    }
}
