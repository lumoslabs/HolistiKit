import UIKit
@testable import FringesExample

protocol SpecViewControllerUI {
    
    var presentedViewController: ViewControlling? { get }
}

class SpecViewController: ViewControlling, SpecViewControllerUI {
    
    var presentedViewController: ViewControlling?

    func present(viewController: ViewControlling) {
        presentedViewController = viewController
    }

    var asUIViewController: UIViewController {
        fatalError("This should never be called in tests")
    }
}
