import Foundation

class TimerInteractor {

    weak var delegate: TimerInteractorDelegate? {
        didSet { updateDelegateWithDate() }
    }

    private let dateProvider: DateProviding
    private let timer: Timing
    private let timerInterval: TimeInterval = 1

    init(dateProvider: DateProviding,
         timerFactory: TimerFactoryProtocol) {
        self.dateProvider = dateProvider
        self.timer = timerFactory.create()
        timer.start(interval: timerInterval, repeats: true) { [weak self] in
            self?.updateDelegateWithDate()
        }
    }

    private func updateDelegateWithDate() {
        delegate?.updateWith(date: dateProvider.date)
    }
}

protocol TimerInteractorDelegate: class {

    func updateWith(date: Date)
}
