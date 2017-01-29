import UIKit
import UIKitFringes

class NetworkRequestViewController: UITableViewController, NetworkRequestViewControlling {

    var presenter: NetworkRequestPresenting!

    @IBOutlet fileprivate weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 44

        presenter.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func set(title text: String) {
        title = text
    }
    
    func set(data text: String) {
        DispatchQueue.main.async { [weak self] in
            self?.textView.text = text
        }
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTap(rowAt: indexPath)
    }
}

protocol NetworkRequestViewControlling: class, ViewControlling {
    
    func set(title text: String)
    func set(data text: String)
}
