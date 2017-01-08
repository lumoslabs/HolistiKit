import UIKit
@testable import FringesExample

class SpecWindow: Windowing {

    var rootViewController: SpecViewController? {
        didSet { rootViewController?.viewDidLoad() }
    }

    var asUIWindow: UIWindow {
        fatalError("This should never be called in tests")
    }
}
    
