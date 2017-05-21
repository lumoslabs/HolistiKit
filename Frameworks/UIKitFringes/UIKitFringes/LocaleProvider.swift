import Foundation

public protocol LocaleProviding {

    var current: Locale { get }
}

class LocaleProvider: LocaleProviding {

    var current: Locale {
        return Locale.current
    }
}
