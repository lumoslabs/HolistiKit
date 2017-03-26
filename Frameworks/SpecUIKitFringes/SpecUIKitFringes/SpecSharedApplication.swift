import Foundation
import UIKitFringes

public class SpecSharedApplication: ApplicationProtocol {

    private weak var system: SpecSystem!

    public init(system: SpecSystem) {
        self.system = system
    }
    
    public var isNetworkActivityIndicatorVisible: Bool = false
    
    public func openURL(_ url: URL) -> Bool {
        if url == URL(string: UIApplicationOpenSettingsURLString)! {
            system.jumpToSettings()
            return true
        }
        return false
    }
}
