import UIKit
import UIKitFringes

class UIViewControllerViewController: UITableViewController, UIViewControllerViewControlling {
    
    var presenter: UIViewControllerPresenting!

    override func viewDidLoad() {
        presenter.viewDidLoad()
    }
    
    func set(title text: String) {
        title = text
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTap(rowAt: indexPath)
    }
}

protocol UIViewControllerViewControlling: class, ViewControlling {
    
    func set(title text: String)
}
