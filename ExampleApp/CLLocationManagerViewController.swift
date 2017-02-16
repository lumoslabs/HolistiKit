import UIKit
import UIKitFringes

class CLLocationManagerViewController: UITableViewController, CLLocationManagerViewControlling {

    // TODO can outlets be private? fileprivate if not?
    @IBOutlet weak var authorizationStatusCell: UITableViewCell!

    var interactor: CLLocationManagerInteractor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
    }

    func set(title text: String) {
        title = text
    }

    func set(authorizationStatus text: String) {
        authorizationStatusCell.textLabel?.text = text
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        interactor.didTap(rowAt: indexPath)
    }
}

protocol CLLocationManagerViewControlling: class, ViewControlling {

    func set(title text: String)
    func set(authorizationStatus text: String)
}
