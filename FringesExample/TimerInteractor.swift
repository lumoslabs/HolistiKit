import Foundation

class TimerInteractor {

    weak var delegate: TimerInteractorDelegate? {
        didSet {
            delegate?.updateWith(date: dateProvider.date)
        }
    }

    private let dateProvider: DateProviding
    private let timerFactory: TimerFactoryProtocol

    init(dateProvider: DateProviding,
         timerFactory: TimerFactoryProtocol) {
        self.dateProvider = dateProvider
        self.timerFactory = timerFactory
    }
}

protocol TimerInteractorDelegate: class {

    func updateWith(date: Date)
}
