import Foundation

class TimerInteractor {

    weak var delegate: TimerInteractorDelegate? {
        didSet {
            delegate?.updateWith(date: dateProvider.date)
        }
    }

    private let dateProvider: DateProviding

    init(dateProvider: DateProviding) {
        self.dateProvider = dateProvider
    }
}

protocol TimerInteractorDelegate: class {

    func updateWith(date: Date)
}
