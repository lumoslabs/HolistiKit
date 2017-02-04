import UIKit

class ExamplesViewControllingFactory: ExamplesViewControllingFactoryProtocol {

    func create(withPresenter presenter: ExamplesPresenter) -> ExamplesViewControlling {
        return ExamplesViewController.create(presenter: presenter)
    }
}

extension ExamplesViewController {

    static let storyboardName = "ExamplesViewController"

    class func create(presenter: ExamplesPresenter) -> ExamplesViewControlling {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! ExamplesViewController
        vc.presenter = presenter
        return vc
    }
}

protocol ExamplesViewControllingFactoryProtocol {
    
    func create(withPresenter presenter: ExamplesPresenter) -> ExamplesViewControlling
}
