import XCTest
import UIKitFringes
import SpecUIKitFringes
@testable import ExampleApp

class ExampleAppTestCase: XCTestCase {

    fileprivate var system: ExampleAppSpecSystem!
    
    override func setUp() {
        super.setUp()
        system = ExampleAppSpecSystem()
    }
}

// MARK: App Launching, Backgrounding, Killing, etc.
extension ExampleAppTestCase {

    func tapAppIcon() {
        system.tapAppIcon()
    }
}

// MARK: Time
extension ExampleAppTestCase {

    func progress(seconds: UInt) {
        dateProvider.progress(seconds: seconds)
    }

    private var dateProvider: SpecDateProvider {
        return system.dateProvider
    }
}

// MARK: Network
extension ExampleAppTestCase {

    func respond(to urlString: String, withHTML html: String) {
        let data = NetworkResponseCreator.data(from: html)
        let url = URL(string: urlString)!
        let urlResponse = URLResponse(url: url,
                                      mimeType: "text/html",
                                      expectedContentLength: data.count,
                                      textEncodingName: "utf-8")
        let requestIdentifier = SpecURLRequestIdentifier(url: urlString, method: .get)
        respond(to: requestIdentifier, with: (data, urlResponse, nil))
    }

    func respond(to urlString: String, withJSON json: [String:Any]) {
        let data = NetworkResponseCreator.data(from: json)
        let url = URL(string: urlString)!
        let urlResponse = URLResponse(url: url,
                                      mimeType: "application/json",
                                      expectedContentLength: data.count,
                                      textEncodingName: nil)
        let requestIdentifier = SpecURLRequestIdentifier(url: urlString, method: .get)
        respond(to: requestIdentifier, with: (data, urlResponse, nil))
    }

    private func respond(to requestIdentifier: SpecURLRequestIdentifier, with response: SpecURLSessionDataTask.Response) {
        urlSession.respond(to: requestIdentifier, with: response)
    }

    private var urlSession: SpecURLSession {
        return system.urlSession
    }
}

// MARK: CLLocationManager
extension ExampleAppTestCase {

    var visibleDialog: SpecDialogManager.DialogIdentifier? {
        return dialogManager.visibleDialog
    }
    
    func dialogResponse(_ response: SpecDialogManager.Response) {
        return dialogManager.tap(response)
    }

    private var dialogManager: SpecDialogManager {
        return system.dialogManager
    }
}

// MARK: CLLocationManager
extension ExampleAppTestCase {

    var userLocation: SpecUserLocation {
        return system.userLocation
    }
}

// MARK: Shared Application
extension ExampleAppTestCase {

    var networkActivityIndicatorIsVisible: Bool {
        return sharedApplication.isNetworkActivityIndicatorVisible
    }

    private var sharedApplication: ApplicationProtocol {
        return system.sharedApplication
    }
}

// MARK: Top View Controller Accessing
extension ExampleAppTestCase {

    var window: UIWindow {
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

    var urlSessionUI: SpecURLSessionViewControllerUI! {
        return topViewController(as: SpecURLSessionViewControllerUI.self)
    }

    var uiViewControllerUI: SpecUIViewControllerViewControllerUI! {
        return topViewController(as: SpecUIViewControllerViewControllerUI.self)
    }

    var clLocationManagerUI: SpecCLLocationManagerViewControllerUI! {
        return topViewController(as: SpecCLLocationManagerViewControllerUI.self)
    }

    var navigationController: UINavigationController {
        guard let navigationController = window.rootViewController?.topViewController.navigationController else {
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
