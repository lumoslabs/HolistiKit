import UIKit
@testable import FringesExample

class SpecDashboardViewControllingFactory: DashboardViewControllingFactoryProtocol {

    func create(withPresenter presenter: DashboardPresenter) -> DashboardViewControlling {
        return SpecDashboardViewController(presenter: presenter)
    }
}

protocol SpecDashboardViewControllerUI: SpecViewControllerUI {
    
    // Input
    func tapOnAddToCountButton()
    func tapOnSettingsButton()
    // Output
    var countLabel: String? { get }
    var backgroundColor: UIColor? { get }
}

class SpecDashboardViewController: SpecViewController, DashboardViewControlling, SpecDashboardViewControllerUI {

    private(set) var backgroundColor: UIColor?
    private(set) var countLabel: String?

    private let presenter: DashboardPresenter

    init(presenter: DashboardPresenter) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    func set(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
    }
    
    func tapOnAddToCountButton() {
        presenter.tapOnAddToCountButton()
    }

    func tapOnSettingsButton() {
        presenter.tapOnSettingsButton()
    }

    func set(countLabel: String) {
        self.countLabel = countLabel
    }
}
