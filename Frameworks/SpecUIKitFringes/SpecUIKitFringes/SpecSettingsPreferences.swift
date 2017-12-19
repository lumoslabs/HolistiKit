import Foundation

public class SpecSettingsPreferences {

    private let userDefaults: SpecUserDefaults
    private let errorHandler: SpecErrorHandler
    private let bundle: Bundle

    public convenience init(userDefaults: SpecUserDefaults) {
        let errorHandler = SpecErrorHandler()
        let bundle = Bundle.main
        self.init(errorHandler: errorHandler,
                  userDefaults: userDefaults,
                  bundle: bundle)
    }

    init(errorHandler: SpecErrorHandler,
         userDefaults: SpecUserDefaults,
         bundle: Bundle) {
        self.errorHandler = errorHandler
        self.userDefaults = userDefaults
        self.bundle = bundle
    }

    public func set(switch key: String, to value: Bool) {
        let requiredSpecifier = Specifier.toggleSwitch(key)
        if !specifiers.contains(requiredSpecifier) {
            errorHandler.error(.noSuchPreferencesSpecifier(requiredSpecifier, specifiers))
        }
        userDefaults.set(value, forKey: key)
    }
    
    private var specifiers: [Specifier] {
        return rawSpecifiers.map(parseSpecifier)
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
        default: return .unsupported
        }
    }

    enum Specifier: CustomStringConvertible {
        case group
        case toggleSwitch(String)
        case unsupported

        public var description: String {
            switch self {
            case .group: return "group"
            case .toggleSwitch(let key): return "toggleSwitch(\(key))"
            case .unsupported: return "unsupported"
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
