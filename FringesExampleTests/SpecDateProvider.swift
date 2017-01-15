import Foundation
@testable import FringesExample

class SpecDateProvider {

    fileprivate lazy var currentDate: Date = {
        let initialDateString = "2016-08-23 00:00:00 +0000"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        return formatter.date(from: initialDateString)!
    }()

    func progress(seconds: Int = 0,
                  minutes: Int = 0,
                  hours: Int = 0,
                  days: Int = 0) {
        let timeInterval = TimeInterval(
            seconds +
            minutes * 60 +
            hours * 60 * 60 +
            days * 24 * 60 * 60
        )
        progress(by: timeInterval)
    }

    private func progress(by timeInterval: TimeInterval) {
        currentDate = currentDate.addingTimeInterval(timeInterval)
    }
}

extension SpecDateProvider: DateProviding {

    var date: Date {
        return currentDate
    }
}
