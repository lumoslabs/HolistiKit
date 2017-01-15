import Foundation
@testable import FringesExample

class SpecDateProvider {

    fileprivate lazy var currentDate: Date = {
        let initialDateString = "2016-08-23 00:00:00 +0000"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        return formatter.date(from: initialDateString)!
    }()

    func progress(minutes: Int) {
        progress(by: TimeInterval(60 * minutes))
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
