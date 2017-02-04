import Foundation

class DateProvider: DateProviding {

    var date: Date {
        return Date()
    }
}


protocol DateProviding {
    
    var date: Date { get }
}
