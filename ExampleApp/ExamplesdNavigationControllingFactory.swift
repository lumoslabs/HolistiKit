class ExamplesNavigationControllingFactory: ExamplesNavigationControllingFactoryProtocol {
    
    func create() -> ExamplesNavigationControlling {
        return ExamplesNavigationController()
    }
}

// TODO rename to `...Controller..` instead of `..Controlling..` (and for others)
protocol ExamplesNavigationControllingFactoryProtocol {
    
    func create() -> ExamplesNavigationControlling
}
