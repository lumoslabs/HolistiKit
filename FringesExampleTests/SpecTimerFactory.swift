@testable import FringesExample

class SpecTimerFactory: TimerFactoryProtocol {

    private let dateProvider: DateProviding

    init(dateProvider: DateProviding) {
        self.dateProvider = dateProvider
    }

    func create() -> Timing {
        return SpecScheduledTimer(dateProvider: dateProvider)
    }
}
