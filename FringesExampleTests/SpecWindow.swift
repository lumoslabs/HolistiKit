import UIKit
@testable import FringesExample

class SpecWindow: Windowing {

    var rootViewController: SpecViewControllerUI?

    var asUIWindow: UIWindow {
        fatalError("This should never be called in tests")
    }
}
    
