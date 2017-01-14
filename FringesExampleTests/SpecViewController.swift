import UIKit
@testable import FringesExample

protocol SpecViewControllerUI {
    
    var presentedViewController: ViewControlling? { get }
}

class SpecViewController: ViewControlling, SpecViewControllerUI {
    
    var navigationControlling: NavigationControlling?
    private(set) var presentedViewController: ViewControlling?

    func viewDidLoad() { }

    func present(viewController: ViewControlling) {
        presentedViewController = viewController
        viewController.viewDidLoadAndAppear()
    }

    func push(viewController: ViewControlling, animated: Bool) {
        navigationControlling!.push(viewController: viewController, animated: animated)
    }

    var asUIViewController: UIViewController {
        fatalError("This should never be called in tests")
    }
}

extension ViewControlling {

    var asSpecViewController: SpecViewController {
        return self as! SpecViewController
    }

    func viewDidLoadAndAppear() {
        asSpecViewController.viewDidLoad()
    }
}
