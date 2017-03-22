import Foundation
import UIKitFringes

class SpecDispatchHandler: DispatchHandling {

    func sync(on _: DispatchQueue, block: @escaping () -> Void) {
        block()
    }

    func async(on _: DispatchQueue, block: @escaping () -> Void) {
        block()
    }
}
