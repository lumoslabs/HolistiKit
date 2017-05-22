import Foundation

public protocol LocaleProviding {

    var current: Locale { get }
}

public class LocaleProvider: LocaleProviding {

    public init() {}

    public var current: Locale {
        return Locale.current
    }
}
