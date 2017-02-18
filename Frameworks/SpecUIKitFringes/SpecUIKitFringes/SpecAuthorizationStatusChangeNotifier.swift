import Foundation

class SpecAuthorizationStatusChangeNotifier {

    static private let notificationCenter = NotificationCenter.default
    static private let notificationName = Notification.Name("SpecAuthorizationStatusChangeNotifier")

    class func post() {
        notificationCenter.post(name: notificationName, object: nil, userInfo: nil)
    }

    class func observe(_ block: @escaping () -> Void) -> NSObjectProtocol {
        return notificationCenter.addObserver(forName: notificationName, object: nil, queue: OperationQueue.main) { _ in
            block()
        }
    }
    
    class func remove(observer: Any?) {
        guard let observer = observer else { return }
        notificationCenter.removeObserver(observer, name: notificationName, object: nil)
    }
}
