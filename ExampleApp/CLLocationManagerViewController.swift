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
}

protocol CLLocationManagerViewControlling: class, ViewControlling {

    func set(title text: String)
    func set(authorizationStatus text: String)
}
