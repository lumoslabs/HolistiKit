import UIKit

extension UINavigationController {

    open override class func initialize() {
        guard self === UINavigationController.self else { return }
        [(#selector(UINavigationController.pushViewController(_:animated:)),
          #selector(UINavigationController.holistikit_pushViewController(_:animated:))),
         (#selector(UINavigationController.setViewControllers(_:animated:)),
          #selector(UINavigationController.holistikit_setViewControllers(_:animated:))),
         (#selector(getter: UINavigationController.topViewController),
          #selector(getter: UINavigationController._topViewController)),
         (#selector(getter: UINavigationController.viewControllers),
          #selector(getter: UINavigationController._viewControllers)),
         (#selector(setter: UINavigationController.viewControllers),
          #selector(setter: UINavigationController._viewControllers))].forEach {
            swizzle(UINavigationController.self, from: $0, to: $1)
        }
    }
    
    @objc private func holistikit_setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        let previous = self.viewControllers.last
        self.viewControllers.forEach { $0._navigationController = nil }
        self.viewControllers = viewControllers
        let newTop = viewControllers.last
        newTop?._navigationController = self
        newTop?.viewDidLoad()
        previous?.viewWillDisappear(animated)
        newTop?.viewWillAppear(animated)
        previous?.viewDidDisappear(animated)
        newTop?.viewDidAppear(animated)
    }

    @objc private func holistikit_pushViewController(_ viewController: UIViewController, animated: Bool) {
        let previous = viewControllers.last
        viewControllers.append(viewController)
        viewController._navigationController = self
        viewController.viewDidLoad()
        previous?.viewWillDisappear(animated)
        viewController.viewWillAppear(animated)
        previous?.viewDidDisappear(animated)
        viewController.viewDidAppear(animated)
    }
    
    @objc private var _viewControllers: [UIViewController] {
        get { return objc_getAssociatedObject(self, &_viewControllersKey) as? [UIViewController] ?? [UIViewController]() }
        set { objc_setAssociatedObject(self, &_viewControllersKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    @objc private var _topViewController: UIViewController? {
        return viewControllers.last
    }
}

private var _viewControllersKey: Void?
