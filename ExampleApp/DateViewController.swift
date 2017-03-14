import UIKit
import UIKitFringes

class DateViewController: UITableViewController {

    var interactor: DateInteractor!
    
    @IBOutlet private weak var viewLoadedAtLabel: UITableViewCell!

    func set(dateLabel text: String) {
        viewLoadedAtLabel.textLabel?.text = text
    }
    
    func set(title text: String) {
        title = text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
    }
}
