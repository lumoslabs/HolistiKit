import UIKitFringes

class CLLocationManagerInteractor {

    private let presenter: CLLocationManagerPresenter
    private let locationManager: LocationManaging

    init(presenter: CLLocationManagerPresenter,
         locationManager: LocationManaging) {
        self.presenter = presenter
        self.locationManager = locationManager
    }

    func viewDidLoad() {
        presenter.set(title: "CLLocationManager")
        presenter.set(authorizationStatus: locationManager.authorizationStatus())
    }

    func tapRequestAuthorization() {
    }
}
