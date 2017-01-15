import UIKit

class SettingsPresenter {

    private let viewControllerFactory: SettingsViewControllerFactoryProtocol
    fileprivate let interactor: SettingsInteractor
    fileprivate let datePrinter: DatePrinter
    fileprivate weak var viewController: SettingsViewControlling!

    init(viewControllerFactory: SettingsViewControllerFactoryProtocol,
         interactor: SettingsInteractor,
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

extension SettingsPresenter: SettingsPresenting {
    
    func viewDidLoad() {
        interactor.delegate = self
    }
}

extension SettingsPresenter: SettingsInteractorDelegate {

    func updateWith(date: Date) {
        let formattedDate = datePrinter.string(for: date, withFormat: .long)
        viewController.set(dateLabel: formattedDate)
    }
}

protocol SettingsPresenting {

    func viewDidLoad()
}
