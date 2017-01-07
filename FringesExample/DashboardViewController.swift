import UIKit

class DashboardViewController: UIViewController, DashboardViewControlling {

    var presenter: DashboardPresenter!

    @IBOutlet weak var countLabel: UILabel!

    @IBAction func tapAddToCountButton() {
        presenter.tapOnAddToCountButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    func present(onWindow window: UIWindow) {
        window.rootViewController = self
    }

    func set(backgroundColor: UIColor) {
        view.backgroundColor = backgroundColor
    }

    func set(countLabel: String) {
        self.countLabel.text = countLabel
    }
}

protocol DashboardViewControlling: class {

    func present(onWindow: UIWindow)
    func set(backgroundColor: UIColor)
    func set(countLabel: String)
}
