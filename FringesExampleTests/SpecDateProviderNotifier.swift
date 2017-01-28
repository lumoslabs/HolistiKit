import Foundation

class SpecDateProviderNotifier {

    static private let notificationCenter = NotificationCenter.default
    static private let notificationName = Notification.Name("SpecDateProviderDateChanged")
    static private let userInfoKey = "Date"

    class func post(date: Date) {
        notificationCenter.post(name: notificationName, object: nil, userInfo: [userInfoKey : date])
    }

    class func observe(_ block: @escaping (Date) -> Void) -> NSObjectProtocol {
        return notificationCenter.addObserver(forName: notificationName, object: nil, queue: OperationQueue.main) { notification in
            let date = notification.userInfo![userInfoKey] as! Date
            block(date)
        }
    }
    
    class func remove(observer: Any) {
        notificationCenter.removeObserver(observer, name: notificationName, object: nil)
    }
}
