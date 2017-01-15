import UIKit

class SettingsViewController: UIViewController, SettingsViewControlling {

    var presenter: SettingsPresenter!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    func set(dateLabel text: String) {
        dateLabel.text = text
    }
}

protocol SettingsViewControlling: class, ViewControlling {
    
    func set(dateLabel text: String)
}
