import UIKit

extension UIViewController: ViewControlling {
    
    public var asUIViewController: UIViewController { return self }
    public var presentedViewControlling: ViewControlling? { return presentedViewController }

    public func present(viewController: ViewControlling) {
        present(viewController.asUIViewController, animated: true, completion: nil)
    }

    public func push(viewController: ViewControlling, animated: Bool) {
        if let navController = self as? UINavigationController {
            navController.pushViewController(viewController.asUIViewController, animated: animated)
        } else {
            navigationController!.pushViewController(viewController.asUIViewController, animated: animated)
        }
    }
}

public protocol ViewControlling {
    
    var asUIViewController: UIViewController { get }
    func present(viewController: ViewControlling)
    func push(viewController: ViewControlling, animated: Bool)
    var presentedViewControlling: ViewControlling? { get }
}
