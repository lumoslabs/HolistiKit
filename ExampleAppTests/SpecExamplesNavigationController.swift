import SpecUIKitFringes
@testable import ExampleApp

class SpecExamplesNavigationControllingFactory: ExamplesNavigationControllingFactoryProtocol {

    func create() -> ExamplesNavigationControlling {
        return SpecExamplesNavigationController()
    }
}

protocol SpecExamplesNavigationControllerUI: SpecNavigationControllerUI {
}

class SpecExamplesNavigationController: SpecNavigationController, ExamplesNavigationControlling, SpecExamplesNavigationControllerUI {
}
