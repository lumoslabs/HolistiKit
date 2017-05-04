import Foundation
import UIKitFringes

public class SpecScheduledTimer: Timing {

    public typealias TimerBlock = () -> Void

    private let dateProvider: SpecDateProvider
    private var block: TimerBlock?
    private var interval: TimeInterval?
    private var startedDate: Date?
    private var lastFiredDate: Date?
    private var repeats: Bool?

    public init(dateProvider: SpecDateProvider) {
        self.dateProvider = dateProvider
        dateProvider.observe(on: self, selector: #selector(dateDidChange))
    }

    @objc
    func dateDidChange() {
        if shouldExecute { execute() }
    }

    private func execute() {
        lastFiredDate = dateProvider.date
        block?()
    }

    private var shouldExecute: Bool {
        return hasRemainingExecutions && enoughTimePassed
    }

    private var hasRemainingExecutions: Bool {
        guard let repeats = repeats else { return false }
        let hasNotExecutedYet = lastFiredDate == nil
        return repeats || hasNotExecutedYet
    }

    private var enoughTimePassed: Bool {
        guard let elapsedTimeInterval = elapsedTimeInterval,
            let interval = interval else { return false }
        return elapsedTimeInterval >= interval
    }

    private var elapsedTimeInterval: TimeInterval? {
        guard let lastDate = lastFiredDate ?? startedDate else { return nil }
        let currentDate = dateProvider.date
        return currentDate.timeIntervalSince(lastDate)
    }

    public func start(interval: TimeInterval, repeats: Bool, block: @escaping TimerBlock) {
        self.interval = interval
        self.block = block
        self.repeats = repeats
        self.startedDate = dateProvider.date
    }
}
