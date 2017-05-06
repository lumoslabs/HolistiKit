import Foundation

public class SpecSettingsPreferences {

    public init() {}

    private var bundle: Bundle {
        return Bundle(for: type(of: self))
    }

    private var settingsBundleSpecifiers: [[String : Any]]? {
        guard let settingsURL = bundle.url(forResource: "Root", withExtension: "plist", subdirectory: "Settings.bundle"),
            let settings = NSDictionary(contentsOf: settingsURL),
            let specifiers = settings["PreferenceSpecifiers"] as? [[String : Any]] else { return nil }
        return specifiers
    }

    public var parsedSpecifiers: [[String : Any]]? {
        return settingsBundleSpecifiers
    }
}
