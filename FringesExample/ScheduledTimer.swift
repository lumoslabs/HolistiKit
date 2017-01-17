import Foundation

class ScheduledTimer: Timing {
    
    private var timer: Timer?

    func start(interval: TimeInterval, repeats: Bool, block: @escaping () -> Void) {
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

protocol Timing {
    
    func start(interval: TimeInterval, repeats: Bool, block: @escaping () -> Void)
}
