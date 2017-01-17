import UIKit

class TimerPresenter {

    private let viewControllerFactory: TimerViewControllerFactoryProtocol
    fileprivate let interactor: TimerInteractor
    fileprivate let datePrinter: DatePrinter
    fileprivate weak var viewController: TimerViewControlling!

    init(viewControllerFactory: TimerViewControllerFactoryProtocol,
         interactor: TimerInteractor,
         datePrinter: DatePrinter) {
        self.viewControllerFactory = viewControllerFactory
        self.interactor = interactor
        self.datePrinter = datePrinter
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
        interactor.delegate = self
    }
}

extension TimerPresenter: TimerInteractorDelegate {

    func updateWith(date: Date) {
        let formattedDate = datePrinter.string(for: date, withFormat: .long)
        viewController.set(dateLabel: formattedDate)
    }
}

protocol TimerPresenting {

    func viewDidLoad()
}
