import Foundation

public class SpecSettingsPreferences {

    private let userDefaults: SpecUserDefaults

    public init(userDefaults: SpecUserDefaults) {
        self.userDefaults = userDefaults
    }
    
    public var specifiers: [Specifier] {
        return rawSpecifiers.map(parseSpecifier)
    }

    public func set(switch key: String, to value: Bool) {
        userDefaults.set(value, forKey: key)
    }

    private var bundle: Bundle {
        return Bundle(for: type(of: self))
    }

    private var settingsURL: URL {
        return bundle.url(forResource: "Root", withExtension: "plist", subdirectory: "Settings.bundle")!
    }

    private var rawSpecifiers: [[String : Any]] {
        let settings = NSDictionary(contentsOf: settingsURL)!
        return settings["PreferenceSpecifiers"] as! [[String : Any]]
    }

    private func parseSpecifier(rawSpecifier: [String : Any]) -> Specifier {
        let type = rawSpecifier["Type"] as! String
        let key = rawSpecifier["Key"] as? String
        switch type {
        case "PSGroupSpecifier": return .group
        case "PSToggleSwitchSpecifier": return .toggleSwitch(key!)
        default:
            fatalError("Preference Specifier type '\(type)' is not supported.")
        }
    }

    public enum Specifier {
        case group
        case toggleSwitch(String)
    }
}

extension SpecSettingsPreferences.Specifier: Equatable {}

public func ==(lhs: SpecSettingsPreferences.Specifier, rhs: SpecSettingsPreferences.Specifier) -> Bool {
    switch (lhs, rhs) {
    case (.group, .group): return true
    case (.toggleSwitch(let lKey), .toggleSwitch(let rKey)):
        return lKey == rKey
    default: return false
    }
}
