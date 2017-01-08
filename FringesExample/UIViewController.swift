import UIKit

extension UIViewController: ViewControlling {
    
    var asUIViewController: UIViewController { return self }

    func present(onWindow window: Windowing) {
        window.asUIWindow.rootViewController = self
    }

    func present(viewController: ViewControlling) {
        present(viewController.asUIViewController, animated: true, completion: nil)
    }
}
