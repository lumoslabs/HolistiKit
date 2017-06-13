import UIKit
import UIKitFringes

public class SpecSharedApplication: ApplicationProtocol {

    private(set) var openedURL: URL?
    private weak var system: SpecSystem!

    public init(system: SpecSystem) {
        self.system = system
    }
    
    public var isNetworkActivityIndicatorVisible: Bool = false
    
    public func openURL(_ url: URL) -> Bool {
        if url == URL(string: UIApplicationOpenSettingsURLString)! {
            system.jumpToSettings()
        } else {
            system.jumpToOtherApp()
        }
        openedURL = url
        return true
    }
}
