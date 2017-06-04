import Foundation
import UIKitFringes

class TimerInteractor {

    private let dateProvider: DateProviding
    private let timerFactory: TimerFactoryProtocol
    private let presenter: TimerPresenter
    private var timer: Timing!
    private let timerInterval: TimeInterval = 1

    init(dateProvider: DateProviding,
         timerFactory: TimerFactoryProtocol,
         presenter: TimerPresenter) {
        self.dateProvider = dateProvider
        self.timerFactory = timerFactory
        self.presenter = presenter
    }

    func viewDidLoad() {
        presenter.set(title: "Timer")
        startUpdatingDate()
    }

    private func startUpdatingDate() {
        updateDate()
        timer = timerFactory.createScheduledTimer(withTimeInterval: timerInterval, repeats: true) { [weak self] _ in
            self?.updateDate()
        }
    }

    private func updateDate() {
        presenter.updateWith(date: dateProvider.date)
    }
}
