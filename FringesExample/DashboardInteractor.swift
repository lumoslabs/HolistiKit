import Foundation

class DashboardInteractor {

    private var count = 0
    private weak var presenter: DashboardPresenter?

    func set(presenter: DashboardPresenter) {
        self.presenter = presenter
    }
    
    func tapOnAddToCountButton() {
        count += 1
        presenter?.set(count: count)
    }
}
