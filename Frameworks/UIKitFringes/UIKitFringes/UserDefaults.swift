import Foundation

public protocol UserDefaulting {
    
    func set(_ value: Any?, forKey defaultName: String)
    func object(forKey defaultName: String) -> Any?
    func integer(forKey defaultName: String) -> Int
}

extension UserDefaults: UserDefaulting { }
