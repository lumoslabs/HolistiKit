import Foundation
@testable import FringesExample

class SpecScheduledTimer: Timing {

    typealias TimerBlock = () -> Void

    private let dateProvider: DateProviding
    private var block: TimerBlock?
    private var dateObserverToken: Any?
    private var lastFiredDate: Date?

    init(dateProvider: DateProviding) {
        self.dateProvider = dateProvider
    }

    func start(interval: TimeInterval, repeats: Bool, block: @escaping TimerBlock) {
        removeObserver()
        lastFiredDate = dateProvider.date
        dateObserverToken = SpecDateProviderNotifier.observe { [weak self] date in
            guard let strongSelf = self, let lastFiredDate = strongSelf.lastFiredDate else { return }
            let currentDate = strongSelf.dateProvider.date
            let delta = currentDate.timeIntervalSince(lastFiredDate)
            if delta >= interval {
                block()
            }
        }
    }

    private func removeObserver() {
        guard let existingToken = dateObserverToken else { return }
        SpecDateProviderNotifier.remove(observer: existingToken)
    }

    deinit {
        removeObserver()
    }
}
