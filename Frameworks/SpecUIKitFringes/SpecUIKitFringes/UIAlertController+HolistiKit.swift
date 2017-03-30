import UIKit

extension UIAlertController {

    typealias Handler = @convention(block) (UIAlertAction) -> Void

    // http://stackoverflow.com/a/40634752/343299
    private func handler(for action: UIAlertAction) -> Handler? {
        let block = action.value(forKey: "handler") as AnyObject
        if block is NSNull { return nil }
        let blockPtr = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(block).toOpaque())
        return unsafeBitCast(blockPtr, to: Handler.self)
    }

    public func tapAction(at index: Int) {
        let action = actions[index]
        let actionHandler = handler(for: action)
        dismiss(animated: true, completion: nil)
        actionHandler?(action)
    }
}
