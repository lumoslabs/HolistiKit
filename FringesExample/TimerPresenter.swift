import UIKit

class TimerPresenter {

    private let viewControllerFactory: TimerViewControllerFactoryProtocol
    fileprivate weak var viewController: TimerViewControlling!

    init(viewControllerFactory: TimerViewControllerFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
    }
    
    func push(on presenter: PushablePresenter) {
        let _viewController = viewControllerFactory.create(withPresenter: self)
        viewController = _viewController
        presenter.push(viewController: _viewController)
    }
}

extension TimerPresenter: TimerPresenting {

    func viewDidLoad() {
        viewController.set(title: "Timer")
    }
}

protocol TimerPresenting {

    func viewDidLoad()
}
