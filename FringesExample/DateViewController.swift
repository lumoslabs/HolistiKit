import UIKit

class DateViewController: UIViewController, DateViewControlling {

    var presenter: DatePresenting!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    func set(dateLabel text: String) {
        dateLabel.text = text
    }
    
    func set(title text: String) {
        title = text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

protocol DateViewControlling: class, ViewControlling {
    
    func set(dateLabel text: String)
    func set(title text: String)
}
