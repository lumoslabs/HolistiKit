import UIKit

extension UIViewController {

    var topViewController: UIViewController {
        return nextViewController?.topViewController ?? self
    }

    var nextViewController: UIViewController? {
        return presentedViewController
    }

    var viewControllerStack: [UIViewController] {
        return (nextViewController?.viewControllerStack ?? []) + [self]
    }
}
