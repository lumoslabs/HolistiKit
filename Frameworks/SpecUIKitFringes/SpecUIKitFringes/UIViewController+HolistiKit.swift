import UIKit

extension UIViewController {

    open class func setupTestSwizzle() {
        guard self === UIViewController.self else { return }
        [(#selector(UIViewController.present(_:animated:completion:)),
          #selector(UIViewController.holistikit_present(_:animated:completion:))),
         (#selector(UIViewController.dismiss(animated:completion:)),
          #selector(UIViewController.holistikit_dismiss(animated:completion:))),
         (#selector(getter: UIViewController.presentedViewController),
          #selector(getter: UIViewController._presentedViewController)),
         (#selector(getter: UIViewController.presentingViewController),
          #selector(getter: UIViewController._presentingViewController)),
         (#selector(getter: UIViewController.navigationController),
          #selector(getter: UIViewController._navigationController))].forEach {
            swizzle(UIViewController.self, from: $0, to: $1)
        }
    }
    
    @objc private func holistikit_dismiss(animated: Bool, completion: (() -> Swift.Void)? = nil) {
        let _presented = presentedViewController ?? self
        guard let _presenting = _presented.presentingViewController else { return }
        _presented._presentingViewController = nil
        _presenting._presentedViewController = nil
        let hidesPresenter = !(_presented is UIAlertController)
        _presented.viewWillDisappear(animated)
        if hidesPresenter {
            if let nav = _presenting as? UINavigationController {
                nav.topViewController!.viewWillAppear(animated)
                nav.viewWillAppear(animated)
                nav.topViewController!.viewDidAppear(animated)
                nav.viewDidAppear(animated)
            } else {
                _presenting.viewWillAppear(animated)
                _presenting.viewDidAppear(animated)
            }
        }
        _presented.viewDidDisappear(animated)
        completion?()
    }

    @objc private func holistikit_present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Swift.Void)? = nil) {
        _presentedViewController = viewControllerToPresent
        viewControllerToPresent._presentingViewController = self
        let hidesPresenter = !(viewControllerToPresent is UIAlertController)
        _ = viewControllerToPresent.view
        if hidesPresenter { self.viewWillDisappear(animated) }
        viewControllerToPresent.viewWillAppear(animated)
        viewControllerToPresent.viewDidAppear(animated)
        if hidesPresenter { self.viewDidDisappear(animated) }
        completion?()
    } 
    
    @objc private var _presentedViewController: UIViewController? {
        get { return objc_getAssociatedObject(self, &_presentedViewControllerKey) as? UIViewController }
        set { objc_setAssociatedObject(self, &_presentedViewControllerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    @objc private var _presentingViewController: UIViewController? {
        get { return objc_getAssociatedObject(self, &_presentingViewControllerKey) as? UIViewController }
        set { objc_setAssociatedObject(self, &_presentingViewControllerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    @objc internal var _navigationController: UINavigationController? {
        get { return objc_getAssociatedObject(self, &_navigationControllerKey) as? UINavigationController }
        set { objc_setAssociatedObject(self, &_navigationControllerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}

private var _presentedViewControllerKey: Void?
private var _presentingViewControllerKey: Void?
private var _navigationControllerKey: Void?
