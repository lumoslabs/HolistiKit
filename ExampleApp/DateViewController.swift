import UIKit
import UIKitFringes

class DateViewController: UITableViewController, DateViewControlling {

    var presenter: DatePresenting!
    
    @IBOutlet weak var viewLoadedAtLabel: UITableViewCell!

    func set(dateLabel text: String) {
        viewLoadedAtLabel.textLabel?.text = text
    }
    
    func set(title text: String) {
        title = text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

protocol DateViewControlling: class, ViewControlling {
    
    func set(dateLabel text: String)
    func set(title text: String)
}
