import Foundation

class ExamplesInteractor {

    private weak var presenter: ExamplesPresenter?

    func set(presenter: ExamplesPresenter) {
        self.presenter = presenter
    }
}
