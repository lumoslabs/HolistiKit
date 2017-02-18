import Foundation

struct SpecAuthorizationStatusChangeNotifier {

    static private let notificationCenter = NotificationCenter.default
    static private let notificationName = Notification.Name("SpecAuthorizationStatusChangeNotifier")

    static func post() {
        notificationCenter.post(name: notificationName, object: nil, userInfo: nil)
    }

    static func observe(on observer: Any, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: notificationName, object: nil)
    }
}
