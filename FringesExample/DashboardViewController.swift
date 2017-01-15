import UIKit

class DashboardViewController: UITableViewController, DashboardViewControlling {

    var presenter: DashboardPresenting!
    private static let cellIdentifier = "DashboardCell"

    @IBOutlet weak var firstRow: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    func set(title text: String) {
        title = text
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DashboardViewController.cellIdentifier,
                                                 for: indexPath)
        let config = presenter.cellConfiguration(for: indexPath)
        cell.textLabel?.text = config.title
        return cell
    }

    override func tableView(_: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows
    }

    override func tableView(_: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        presenter.tap(rowAt: indexPath)
    }
}

protocol DashboardViewControlling: class, ViewControlling {

    func set(title: String)
}
