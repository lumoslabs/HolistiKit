import UIKit

extension UIWindow {

    var topViewController: UIViewController {
        return rootViewController!.topViewController
    }

    var viewControllerStack: [UIViewController] {
        return rootViewController!.viewControllerStack
    }
}
