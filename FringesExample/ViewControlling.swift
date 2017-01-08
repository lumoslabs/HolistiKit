import UIKit

protocol ViewControlling {
    
    var asUIViewController: UIViewController { get }
    func present(viewController: ViewControlling)
}

