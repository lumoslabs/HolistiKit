import UIKit
@testable import FringesExample

class SpecWindow: Windowing {

    var rootViewController: ViewControlling?

    var asUIWindow: UIWindow {
        fatalError("This should never be called in tests")
    }
}
    
