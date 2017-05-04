import UIKitFringes

public class SpecTimerFactory: TimerFactoryProtocol {

    private let dateProvider: SpecDateProvider

    public init(dateProvider: SpecDateProvider) {
        self.dateProvider = dateProvider
    }

    public func createScheduledTimer(withTimeInterval timeInterval: TimeInterval, repeats: Bool, block: @escaping () -> Void) -> Timing {
        return SpecTimer(dateProvider: dateProvider, interval: timeInterval, repeats: repeats, block: block)
    }
}
