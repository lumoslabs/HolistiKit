import UIKit

class DashboardViewController: UIViewController, DashboardViewControlling {

    var presenter: DashboardPresenter!

    @IBOutlet weak var countLabel: UILabel!

    @IBAction func tapAddToCountButton() {
        presenter.tapOnAddToCountButton()
    }

    @IBAction func tapSettingsButton() {
        presenter.tapOnSettingsButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    func set(backgroundColor: UIColor) {
        view.backgroundColor = backgroundColor
    }

    func set(countLabel text: String) {
        countLabel.text = text
    }
}

protocol DashboardViewControlling: class, ViewControlling {

    func set(backgroundColor: UIColor)
    func set(countLabel: String)
}
