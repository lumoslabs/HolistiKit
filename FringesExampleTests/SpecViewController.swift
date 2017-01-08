import UIKit
@testable import FringesExample

protocol SpecViewControllerUI {
    
    var presentedViewController: ViewControlling? { get }
}

class SpecViewController: ViewControlling, SpecViewControllerUI {
    
    var presentedViewController: ViewControlling?

    func viewDidLoad() { }

    func present(onWindow window: Windowing) {
        let specWindow = window as! SpecWindow
        specWindow.rootViewController = self
        viewDidLoad()
    }

    func present(viewController: ViewControlling) {
        presentedViewController = viewController
    }

    var asUIViewController: UIViewController {
        fatalError("This should never be called in tests")
    }
}
