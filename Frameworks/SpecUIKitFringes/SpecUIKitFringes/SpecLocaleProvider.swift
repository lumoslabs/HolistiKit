import Foundation
import UIKitFringes

public class SpecLocaleProvider: LocaleProviding {

    public init() {}

    public private(set) var current = Locale(identifier: "ha_GH")
    
    public func set(locale: Locale) {
        current = locale
    }
}
