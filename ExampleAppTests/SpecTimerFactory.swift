import UIKitFringes
import SpecUIKitFringes
@testable import ExampleApp

class SpecTimerFactory: TimerFactoryProtocol {

    private let dateProvider: SpecDateProvider

    init(dateProvider: SpecDateProvider) {
        self.dateProvider = dateProvider
    }

    func create() -> Timing {
        return SpecScheduledTimer(dateProvider: dateProvider)
    }
}
