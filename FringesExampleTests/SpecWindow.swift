import UIKit
@testable import FringesExample

class SpecWindow: Windowing {

    private(set) var rootViewController: ViewControlling?
    
    func set(rootViewController: ViewControlling) {
        self.rootViewController = rootViewController
        rootViewController.viewDidLoadAndAppear()
    }

    var asUIWindow: UIWindow {
        fatalError("This should never be called in tests")
    }
}
    
