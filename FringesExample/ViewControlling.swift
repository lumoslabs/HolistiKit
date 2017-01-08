import UIKit

protocol ViewControlling {
    
    var asUIViewController: UIViewController { get }
    func present(onWindow: Windowing)
    func present(viewController: ViewControlling)
    func viewDidLoad()
}

