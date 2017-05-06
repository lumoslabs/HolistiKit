import Foundation

public class SpecSettingsPreferences {

    private let userDefaults: SpecUserDefaults
    private let errorHandler: SpecErrorHandler

    public convenience init(userDefaults: SpecUserDefaults) {
        let errorHandler = SpecErrorHandler()
        self.init(errorHandler: errorHandler,
                  userDefaults: userDefaults)
    }

    init(errorHandler: SpecErrorHandler,
         userDefaults: SpecUserDefaults) {
        self.errorHandler = errorHandler
        self.userDefaults = userDefaults
    }

    public func set(switch key: String, to value: Bool) {
        if !specifiers.contains(.toggleSwitch(key)) {
            errorHandler.error(.noSuchPreferencesSpecifier(.toggleSwitch(key), specifiers))
        }
        userDefaults.set(value, forKey: key)
    }
    
    private var specifiers: [Specifier] {
        return rawSpecifiers.map(parseSpecifier)
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

    enum Specifier: CustomStringConvertible {
        case group
        case toggleSwitch(String)

        public var description: String {
            switch self {
            case .group: return "group"
            case .toggleSwitch(let key): return "toggleSwitch(\(key))"
            }
        }
    }
}

extension SpecSettingsPreferences.Specifier: Equatable {}

func ==(lhs: SpecSettingsPreferences.Specifier, rhs: SpecSettingsPreferences.Specifier) -> Bool {
    switch (lhs, rhs) {
    case (.group, .group): return true
    case (.toggleSwitch(let lKey), .toggleSwitch(let rKey)):
        return lKey == rKey
    default: return false
    }
}
