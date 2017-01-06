import UIKit

class AppCoordinator {

    let router: RootRouter

    init(router: RootRouter) {
        self.router = router
    }
    
    func didFinishLaunching(withWindow window: UIWindow) {
        router.present(onWindow: window)
    }
}
