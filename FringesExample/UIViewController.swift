import UIKit

extension UIViewController: ViewControlling {
    
    var asUIViewController: UIViewController { return self }

    var navigationControlling: NavigationControlling? { return navigationController }

    func present(onWindow window: Windowing) {
        window.asUIWindow.rootViewController = self
    }

    func present(viewController: ViewControlling) {
        present(viewController.asUIViewController, animated: true, completion: nil)
    }

    func push(viewController: ViewControlling, animated: Bool) {
        if let navController = self as? UINavigationController {
            navController.pushViewController(viewController.asUIViewController, animated: animated)
        } else {
            navigationController!.pushViewController(viewController.asUIViewController, animated: animated)
        }
    }
}