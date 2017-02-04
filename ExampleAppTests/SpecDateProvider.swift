import Foundation
@testable import ExampleApp

class SpecDateProvider: DateProviding {

    private(set) lazy var date: Date = {
        let initialDateString = "2016-08-23 00:00:00 +0000"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        return formatter.date(from: initialDateString)!
    }()

    func progress(seconds: Int) {
        for _ in 0..<seconds {
            date = date.addingTimeInterval(1)
            SpecDateProviderNotifier.post(date: date)
        }
    }
}
