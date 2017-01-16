import UIKit

class TimerViewController: UIViewController, TimerViewControlling {

    var presenter: TimerPresenting!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    func set(title text: String) {
        title = text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

protocol TimerViewControlling: class, ViewControlling {
    
    func set(title text: String)
}
