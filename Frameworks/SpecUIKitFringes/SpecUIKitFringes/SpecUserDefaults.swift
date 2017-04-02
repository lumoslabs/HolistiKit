import Foundation
import UIKitFringes

public class SpecUserDefaults: UserDefaulting {

    private var store = [String : Any?]()

    public init() { }

    public func object(forKey key: String) -> Any? {
        return store[key]
    }

    public func set(_ value: Any?, forKey key: String) {
        store[key] = value
    }
}
