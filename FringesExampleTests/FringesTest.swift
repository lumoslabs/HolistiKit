import XCTest
@testable import FringesExample

class FringesTest: XCTestCase {

    private(set) var appDelegate: SpecAppDelegate!
    
    override func setUp() {
        super.setUp()

        appDelegate = SpecAppDelegate()
    }
}

extension FringesTest {

    func tapAppIcon() {
        appDelegate.applicationDidLaunch()
    }
}

extension FringesTest {

    private func topViewController<I>(as interface: I.Type) -> I {
        if let top = appDelegate.window.topViewController as? I {
            return top
        }
        let currentViewControllerStack = appDelegate.window.viewControllerStack
            .enumerated()
            .map { "[\($0)] [\($1)]" }
            .joined(separator: "\n")
        fatalError("\nThe top view controller was not an instance of [\(I.self)]\n" +
            "This is the current view controller stack:\n" +
            "\(currentViewControllerStack)\n" +
            "[ ] Window\n")
    }

    var dashboard: SpecDashboardViewControllerUI! {
        return topViewController(as: SpecDashboardViewControllerUI.self)
    }

    var settings: SpecSettingsViewControllerUI! {
        return topViewController(as: SpecSettingsViewControllerUI.self)
    }
}
