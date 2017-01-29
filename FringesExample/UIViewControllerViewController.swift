import UIKit
import UIKitFringes

class UIViewControllerViewController: UIViewController, UIViewControllerViewControlling {
    
    var presenter: UIViewControllerPresenting!
    
    func set(title text: String) {
        title = text
    }

    override func viewDidLoad() {
        presenter.viewDidLoad()
    }
}

protocol UIViewControllerViewControlling: class, ViewControlling {
    
    func set(title text: String)
}
