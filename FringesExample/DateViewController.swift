import UIKit

class DateViewController: UIViewController, DateViewControlling {

    var presenter: DatePresenter!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    func set(dateLabel text: String) {
        dateLabel.text = text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

protocol DateViewControlling: class, ViewControlling {
    
    func set(dateLabel text: String)
}
