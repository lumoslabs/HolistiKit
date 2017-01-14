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

    private var topViewController: SpecViewController? {
        return appDelegate.window.topViewController
    }

    var dashboardNav: SpecDashboardNavigationControllerUI! {
        return topViewController as! SpecDashboardNavigationControllerUI
    }

    var dashboard: SpecDashboardViewControllerUI! {
        return topViewController as! SpecDashboardViewControllerUI
    }

    var settings: SpecSettingsViewControllerUI! {
        return topViewController as! SpecSettingsViewControllerUI
    }
}
