import UIKit

protocol ViewControlling {
    
    var asUIViewController: UIViewController { get }
    // TODO move this to the Windowing protocol
    func present(onWindow: Windowing)
    func present(viewController: ViewControlling)
    func push(viewController: ViewControlling, animated: Bool)
    func viewDidLoad()
    var navigationControlling: NavigationControlling? { get }
}

