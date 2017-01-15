import Foundation

class SettingsInteractor {

    weak var delegate: SettingsInteractorDelegate? {
        didSet {
            delegate?.updateWith(date: dateProvider.date)
        }
    }

    private let dateProvider: DateProviding

    init(dateProvider: DateProviding) {
        self.dateProvider = dateProvider
    }
}

protocol SettingsInteractorDelegate: class {

    func updateWith(date: Date)
}
