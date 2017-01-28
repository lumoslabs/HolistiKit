import XCTest
import UIKitFringes
import SpecUIKitFringes
@testable import FringesExample

class FringesTest: XCTestCase {

    fileprivate var system: FringesSpecSystem!
    
    override func setUp() {
        super.setUp()
        system = FringesSpecSystem()
    }
}

// MARK: App Launching, Backgrounding, Killing, etc.
extension FringesTest {

    func tapAppIcon() {
        system.tapAppIcon()
    }
}

// MARK: Time
extension FringesTest {

    func progress(seconds: Int) {
        dateProvider.progress(seconds: seconds)
    }

    private var dateProvider: SpecDateProvider {
        return system.dateProvider
    }
}

// MARK: Network
extension FringesTest {

    func respond(to urlRequest: SpecURLSession.RequestURL, with json: [String:Any]) {
        let data = NetworkResponseCreator.data(from: json)
        respond(to: urlRequest, with: .success(data))
    }

    func respond(to urlRequest: SpecURLSession.RequestURL, with response: SpecURLSession.Response) {
        urlSession.respond(to: urlRequest, with: response)
    }

    private var urlSession: SpecURLSession {
        return system.urlSession
    }
}

extension FringesTest {

    var networkActivityIndicatorIsVisible: Bool {
        return sharedApplication.isNetworkActivityIndicatorVisible
    }

    private var sharedApplication: ApplicationProtocol {
        return system.sharedApplication
    }
}

// MARK: Top View Controller Accessing
extension FringesTest {

    var window: SpecWindow {
        guard let window = system.appDelegate.window else {
            fatalError("There is no window. Did you forget to launch the app?")
        }
        return window
    }

    var examplesUI: SpecExamplesViewControllerUI! {
        return topViewController(as: SpecExamplesViewControllerUI.self)
    }

    var dateUI: SpecDateViewControllerUI! {
        return topViewController(as: SpecDateViewControllerUI.self)
    }

    var timerUI: SpecTimerViewControllerUI! {
        return topViewController(as: SpecTimerViewControllerUI.self)
    }

    var networkRequestUI: SpecNetworkRequestViewControllerUI! {
        return topViewController(as: SpecNetworkRequestViewControllerUI.self)
    }

    var navigationController: SpecNavigationControllerUI {
        guard let navigationController = window.topViewController.navigationController else {
            fatalError("The top view controller is not inside a navigation controller.")
        }
        return navigationController
    }

    private func topViewController<I>(as interface: I.Type) -> I {
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
}
