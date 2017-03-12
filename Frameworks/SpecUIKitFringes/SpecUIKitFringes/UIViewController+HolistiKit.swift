import UIKit

extension UIViewController {

    open override class func initialize() {
        guard self === UIViewController.self else { return }
        swizzle(UIViewController.self,
                from: #selector(UIViewController.viewWillAppear(_:)),
                to: #selector(UIViewController.proj_viewWillAppear(animated:)))
    }

    func proj_viewWillAppear(animated: Bool) {
        self.proj_viewWillAppear(animated: animated)

        let viewControllerName = NSStringFromClass(type(of: self))
        print("viewWillAppear: \(viewControllerName)")
    } 
}
