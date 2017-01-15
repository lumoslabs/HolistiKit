import Foundation

class DateInteractor {

    weak var delegate: DateInteractorDelegate? {
        didSet {
            delegate?.updateWith(date: dateProvider.date)
        }
    }

    private let dateProvider: DateProviding

    init(dateProvider: DateProviding) {
        self.dateProvider = dateProvider
    }
}

protocol DateInteractorDelegate: class {

    func updateWith(date: Date)
}
