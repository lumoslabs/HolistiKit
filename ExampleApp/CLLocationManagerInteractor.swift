import CoreLocation

class CLLocationManagerInteractor {

    private let presenter: CLLocationManagerPresenter

    init(presenter: CLLocationManagerPresenter) {
        self.presenter = presenter
    }

    func viewDidLoad() {
        presenter.set(title: "CLLocationManager")
        presenter.set(authorizationStatus: CLLocationManager.authorizationStatus())
    }
}
