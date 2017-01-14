import UIKit

protocol Windowing {

    var asUIWindow: UIWindow { get }
    func set(rootViewController: ViewControlling)
}
