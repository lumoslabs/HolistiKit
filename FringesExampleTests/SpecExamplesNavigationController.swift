import UIKit
@testable import FringesExample

class SpecExamplesNavigationControllingFactory: ExamplesNavigationControllingFactoryProtocol {

    func create() -> ExamplesNavigationControlling {
        return SpecExamplesNavigationController()
    }
}

protocol SpecExamplesNavigationControllerUI: SpecNavigationControllerUI {
}

class SpecExamplesNavigationController: SpecNavigationController, ExamplesNavigationControlling, SpecExamplesNavigationControllerUI {
}
