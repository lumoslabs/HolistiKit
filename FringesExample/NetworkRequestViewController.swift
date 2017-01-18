import UIKit

class NetworkRequestViewController: UITableViewController, NetworkRequestViewControlling {

    var presenter: NetworkRequestPresenting!
    
    @IBOutlet weak var dateCell: UITableViewCell!
    
    func set(title text: String) {
        title = text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

protocol NetworkRequestViewControlling: class, ViewControlling {
    
    func set(title text: String)
}
