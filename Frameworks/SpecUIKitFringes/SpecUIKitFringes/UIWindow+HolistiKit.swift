import UIKit

extension UIWindow {

    open override class func initialize() {
        guard self === UIWindow.self else { return }
        [(#selector(setter: UIWindow.rootViewController),
          #selector(setter: UIWindow.holistikit_rootViewController)),
         (#selector(getter: UIWindow.rootViewController),
          #selector(getter: UIWindow.holistikit_rootViewController))].forEach {
            swizzle(UIWindow.self, from: $0, to: $1)
        }
    }

    @objc private var holistikit_rootViewController: UIViewController? {
        get { return _rootViewController }
        set {
            if let previous = _rootViewController {
                _rootViewController = newValue
                previous.viewWillDisappear(false)
                _ = newValue?.view
                newValue?.viewWillAppear(false)
                previous.viewDidDisappear(false)
                newValue?.viewDidAppear(false)
            } else {
                _rootViewController = newValue
                _ = newValue?.view
                newValue?.viewWillAppear(false)
                newValue?.viewDidAppear(false)
            }
        }
    }
    
    private var _rootViewController: UIViewController? {
        get { return objc_getAssociatedObject(self, &_rootViewControllerKey) as? UIViewController }
        set { objc_setAssociatedObject(self, &_rootViewControllerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}

private var _rootViewControllerKey: Void?
