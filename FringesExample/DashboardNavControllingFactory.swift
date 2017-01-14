class DashboardNavigationControllingFactory: DashboardNavigationControllingFactoryProtocol {
    
    func create() -> DashboardNavigationControlling {
        return DashboardNavigationController()
    }
}

protocol DashboardNavigationControllingFactoryProtocol {
    
    func create() -> DashboardNavigationControlling
}
