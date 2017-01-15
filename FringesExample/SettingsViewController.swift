import UIKit

class SettingsViewController: UIViewController, SettingsViewControlling {

    var presenter: SettingsPresenter!
}

protocol SettingsViewControlling: class, ViewControlling {
}
