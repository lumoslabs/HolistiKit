import UIKit

class DashboardViewController: UITableViewController, DashboardViewControlling {

    var presenter: DashboardPresenter!

    @IBOutlet weak var firstRow: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    func set(title text: String) {
        title = text
    }
    
    func set(firstRowTitle text: String) {
        firstRow.textLabel?.text = text
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.tap(rowAt: indexPath)
    }
}

protocol DashboardViewControlling: class, ViewControlling {

    func set(title: String)
    func set(firstRowTitle: String)
}
