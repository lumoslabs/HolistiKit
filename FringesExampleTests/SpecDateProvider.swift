import Foundation
@testable import FringesExample

class SpecDateProvider {

    fileprivate lazy var currentDate: Date = {
        let initialDateString = "2016-08-23 00:00:00 +0000"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        return formatter.date(from: initialDateString)!
    }()

    func progress(seconds: Int = 0) {
        for _ in 0..<seconds {
            currentDate = currentDate.addingTimeInterval(1)
            SpecDateProviderNotifier.post(date: currentDate)
        }
    }
}

extension SpecDateProvider: DateProviding {

    var date: Date {
        return currentDate
    }
}

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
