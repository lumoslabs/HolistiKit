import UIKit

extension UIViewController {

    open override class func initialize() {
        guard self === UIViewController.self else { return }
        [(#selector(UIViewController.present(_:animated:completion:)),
          #selector(UIViewController.holistikit_present(_:animated:completion:)))].forEach {
            swizzle(UIViewController.self, from: $0, to: $1)
        }
    }

    func holistikit_present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Swift.Void)? = nil) {
        viewControllerToPresent.viewDidLoad()
        self.viewWillDisappear(animated)
        viewControllerToPresent.viewWillAppear(animated)
        viewControllerToPresent.viewDidAppear(animated)
        self.viewDidDisappear(animated)
    } 
}
