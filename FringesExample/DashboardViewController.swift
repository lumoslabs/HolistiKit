import UIKit

class DashboardViewController: UITableViewController, DashboardViewControlling {

    var presenter: DashboardPresenter!

    @IBOutlet weak var firstRow: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    func set(firstRowTitle text: String) {
        firstRow.textLabel?.text = text
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.tapFirstRow()
    }
}

protocol DashboardViewControlling: class, ViewControlling {

    func set(firstRowTitle: String)
}
