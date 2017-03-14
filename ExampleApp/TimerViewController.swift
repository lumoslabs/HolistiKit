import UIKit
import UIKitFringes

class TimerViewController: UITableViewController {

    var interactor: TimerInteractor!
    
    @IBOutlet private weak var dateCell: UITableViewCell!
    
    func set(title text: String) {
        title = text
    }
    
    func set(dateLabel text: String) {
        dateCell.textLabel?.text = text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
    }
}
