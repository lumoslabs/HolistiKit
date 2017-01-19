import UIKit

class NetworkRequestViewController: UITableViewController, NetworkRequestViewControlling {

    var presenter: NetworkRequestPresenting!
    
    @IBOutlet weak var dataCell: UITableViewCell!
    
    func set(title text: String) {
        title = text
    }
    
    func set(data text: String) {
        dataCell.textLabel?.text = text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

protocol NetworkRequestViewControlling: class, ViewControlling {
    
    func set(title text: String)
    func set(data text: String)
}
