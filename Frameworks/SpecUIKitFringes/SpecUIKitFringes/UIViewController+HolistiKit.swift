import UIKit

extension UIViewController {

    open override class func initialize() {
        guard self === UIViewController.self else { return }
        [(#selector(UIViewController.present(_:animated:completion:)),
          #selector(UIViewController.holistikit_present(_:animated:completion:))),
         (#selector(getter: UIViewController.presentedViewController),
          #selector(getter: UIViewController._presentedViewController)),
         (#selector(getter: UIViewController.presentingViewController),
          #selector(getter: UIViewController._presentingViewController))].forEach {
            swizzle(UIViewController.self, from: $0, to: $1)
        }
    }

    @objc private func holistikit_present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Swift.Void)? = nil) {
        _presentedViewController = viewControllerToPresent
        viewControllerToPresent._presentingViewController = self
        viewControllerToPresent.viewDidLoad()
        self.viewWillDisappear(animated)
        viewControllerToPresent.viewWillAppear(animated)
        viewControllerToPresent.viewDidAppear(animated)
        self.viewDidDisappear(animated)
    } 
    
    @objc private var _presentedViewController: UIViewController? {
        get { return objc_getAssociatedObject(self, &_presentedViewControllerKey) as? UIViewController }
        set { objc_setAssociatedObject(self, &_presentedViewControllerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    @objc private var _presentingViewController: UIViewController? {
        get { return objc_getAssociatedObject(self, &_presentingViewControllerKey) as? UIViewController }
        set { objc_setAssociatedObject(self, &_presentingViewControllerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}

private var _presentedViewControllerKey: Void?
private var _presentingViewControllerKey: Void?
