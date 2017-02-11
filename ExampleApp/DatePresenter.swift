import UIKitFringes

class DatePresenter {

    fileprivate let viewControllerFactory: DateViewControllerFactoryProtocol
    fileprivate let interactor: DateInteractor
    fileprivate let datePrinter: DatePrinter
    fileprivate weak var viewController: DateViewControlling!

    init(viewControllerFactory: DateViewControllerFactoryProtocol,
         interactor: DateInteractor,
         datePrinter: DatePrinter) {
        self.viewControllerFactory = viewControllerFactory
        self.interactor = interactor
        self.datePrinter = datePrinter
    }
}

extension DatePresenter: Presenting {

    var viewControlling: ViewControlling {
        if let viewController = viewController { return viewController }
        let _viewController = viewControllerFactory.create(withPresenter: self)
        viewController = _viewController
        return _viewController
    }
}

extension DatePresenter: DatePresenting {
    
    func viewDidLoad() {
        viewController.set(title: "Date")
        interactor.delegate = self
    }
}

extension DatePresenter: DateInteractorDelegate {

    func updateWith(date: Date) {
        let formattedDate = datePrinter.string(for: date, withFormat: .long)
        viewController.set(dateLabel: formattedDate)
    }
}

protocol DatePresenting {

    func viewDidLoad()
}
