class TimerFactory: TimerFactoryProtocol {
    
    func create() -> Timing {
        return ScheduledTimer()
    }
}

protocol TimerFactoryProtocol {

    func create() -> Timing
}
