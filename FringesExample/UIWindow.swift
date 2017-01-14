import UIKit

extension UIWindow: Windowing {

    var asUIWindow: UIWindow { return self }

    func set(rootViewController: ViewControlling) {
        self.rootViewController = rootViewController.asUIViewController
    }
}
