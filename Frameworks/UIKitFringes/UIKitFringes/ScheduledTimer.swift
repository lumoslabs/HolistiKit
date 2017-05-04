import Foundation

public class TimerFactory: TimerFactoryProtocol {

    public init() { }
    
    public func createScheduledTimer(withTimeInterval timeInterval: TimeInterval, repeats: Bool, block: @escaping () -> Void) -> Timing {
        let timer = ScheduledTimer()
        timer.start(interval: timeInterval, repeats: repeats, block: block)
        return timer
    }
}

public protocol TimerFactoryProtocol {

    func createScheduledTimer(withTimeInterval: TimeInterval, repeats: Bool, block: @escaping () -> Void) -> Timing
}

public class ScheduledTimer: Timing {

    private var timer: Timer?

    public func invalidate() {
        timer?.invalidate()
    }

    fileprivate func start(interval: TimeInterval, repeats: Bool, block: @escaping () -> Void) {
        // invalidate timer if already started
        self.timer?.invalidate()
        
        self.timer = Timer.scheduledTimer(timeInterval: interval,
                                          target: WeakTarget(block: block),
                                          selector: #selector(WeakTarget.execute),
                                          userInfo: nil,
                                          repeats: true)
    }

    deinit {
        self.timer?.invalidate()
    }

    class WeakTarget {
        
        private var block: (() -> Void)?

        init(block: @escaping () -> Void) {
            self.block = block
        }

        @objc func execute() {
            self.block?()
        }
    }
}

public protocol Timing {
    
    func invalidate()
}
