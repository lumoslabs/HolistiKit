class ExamplesNavigationControllingFactory: ExamplesNavigationControllingFactoryProtocol {
    
    func create() -> ExamplesNavigationControlling {
        return ExamplesNavigationController()
    }
}

protocol ExamplesNavigationControllingFactoryProtocol {
    
    func create() -> ExamplesNavigationControlling
}
