import UIKit
import UIKitFringes

class CLLocationManagerViewController: UITableViewController, CLLocationManagerViewControlling {

    var interactor: CLLocationManagerInteractor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
    }

    func set(title text: String) {
        title = text
    }
}

protocol CLLocationManagerViewControlling: class, ViewControlling {

    func set(title text: String)
}
