import Foundation
import UIKitFringes

public class SpecUserDefaults: UserDefaulting {
    public func removeObject(forKey defaultName: String) {
        store.removeValue(forKey: defaultName)
    }

    private let notificationCenter: NotificationCentering
    private var store = [String : Any?]()

    public convenience init() {
        let notificationCenter = NotificationCenter.default
        self.init(notificationCenter: notificationCenter)
    }
    
    init(notificationCenter: NotificationCentering) {
        self.notificationCenter = notificationCenter
    }

    public func set(_ value: Any?, forKey key: String) {
        store[key] = value
        notificationCenter.post(name: UserDefaults.didChangeNotification, object: nil)
    }

    public func object(forKey key: String) -> Any? {
        return store[key] ?? nil
    }
    
    public func integer(forKey key: String) -> Int {
        let obj = object(forKey: key)
        if let int = obj as? Int {
            return int
        }
        if let str = obj as? String, let int = Int(str) {
            return int
        }
        if let bool = obj as? Bool {
            return bool ? 1 : 0
        }
        return 0
    }
    
    public func bool(forKey key: String) -> Bool {
        let obj = object(forKey: key)
        if let boolean = obj as? Bool {
            return boolean
        }
        if let str = obj as? String, ["YES", "true"].contains(str) {
            return true
        }
        if let int = obj as? Int {
            return int != 0
        }
        return false
    }
}
