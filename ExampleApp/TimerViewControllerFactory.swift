import UIKit

class TimerViewControllerFactory: TimerViewControllerFactoryProtocol {
    
    func create(withPresenter presenter: TimerPresenter) -> TimerViewControlling {
        return TimerViewController.create(presenter: presenter)
    }
}

extension TimerViewController {

    static let storyboardName = "TimerViewController"

    class func create(presenter: TimerPresenter) -> TimerViewController {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! TimerViewController
        vc.presenter = presenter
        return vc
    }
}

protocol TimerViewControllerFactoryProtocol {
    
    func create(withPresenter presenter: TimerPresenter) -> TimerViewControlling
}
