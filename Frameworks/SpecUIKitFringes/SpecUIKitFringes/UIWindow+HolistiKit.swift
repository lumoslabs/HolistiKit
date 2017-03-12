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

    var holistikit_rootViewController: UIViewController? {
        get { return _rootViewController }
        set {
            _rootViewController = newValue
            _rootViewController?.viewDidLoad()
            _rootViewController?.viewWillAppear(false)
            _rootViewController?.viewDidAppear(false)
        }
    }
    
    var _rootViewController: UIViewController? {
        get { return objc_getAssociatedObject(self, &_rootViewControllerKey) as? UIViewController }
        set { objc_setAssociatedObject(self, &_rootViewControllerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}

private var _rootViewControllerKey: Void?
