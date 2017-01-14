import Foundation

class DashboardInteractor {

    private weak var presenter: DashboardPresenter?

    func set(presenter: DashboardPresenter) {
        self.presenter = presenter
    }
}
