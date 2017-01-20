import UIKit

extension UIApplication: ApplicationProtocol { }

protocol ApplicationProtocol: class {

    var isNetworkActivityIndicatorVisible: Bool { get set }
}
