import UIKit

class SettingsViewController: UIViewController, SettingsViewControlling {

    var presenter: SettingsPresenter!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    func set(dateLabel text: String) {
        dateLabel.text = text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

protocol SettingsViewControlling: class, ViewControlling {
    
    func set(dateLabel text: String)
}
