import XCTest
@testable import FringesExample

class FringesTest: XCTestCase {

    private(set) var appDelegate: SpecAppDelegate!
    
    override func setUp() {
        super.setUp()
        appDelegate = SpecAppDelegate()
    }
}

// MARK: App Launching, Backgrounding, Killing, etc.
extension FringesTest {

    func tapAppIcon() {
        appDelegate.applicationDidLaunch()
    }
}

// MARK: Time
extension FringesTest {

    func progress(minutes: Int) {
        appDelegate.dateProvider.progress(minutes: 1)
    }
}

// MARK: Top View Controller Accessing
extension FringesTest {

    private func topViewController<I>(as interface: I.Type) -> I {
        guard let window = appDelegate.window else {
            fatalError("There is no window. Did you forget to launch the app?")
        }
        if let top = window.topViewController as? I {
            return top
        }
        let currentViewControllerStack = window.viewControllerStack
            .enumerated()
            .map { "[\($0)] [\($1)]" }
            .joined(separator: "\n")
        fatalError("\nThe top view controller was not an instance of [\(I.self)]\n" +
            "This is the current view controller stack:\n" +
            "\(currentViewControllerStack)\n" +
            "[-] Window\n")
    }

    var dashboard: SpecDashboardViewControllerUI! {
        return topViewController(as: SpecDashboardViewControllerUI.self)
    }

    var settings: SpecSettingsViewControllerUI! {
        return topViewController(as: SpecSettingsViewControllerUI.self)
    }
}
