import UIKitFringes

class CLLocationManagerPresenter {
    
    fileprivate weak var viewController: CLLocationManagerViewControlling!

    func set(viewController: CLLocationManagerViewControlling) {
        self.viewController = viewController
    }

    func set(title text: String) {
        viewController.set(title: text)
    }
}
