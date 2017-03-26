import UIKit

extension UIApplication: ApplicationProtocol { }

public protocol ApplicationProtocol: class {

    var isNetworkActivityIndicatorVisible: Bool { get set }
    func openURL(_ url: URL) -> Bool
}
