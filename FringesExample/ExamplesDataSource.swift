import Foundation

class ExamplesDataSource {

    private let data = [
        ExamplesCellConfig(title: "Date"),
        ExamplesCellConfig(title: "Timer")
    ]
    
    func cellConfiguration(for indexPath: IndexPath) -> ExamplesCellConfig {
        let row = indexPath.row
        return data[row]
    }

    var numberOfRows: Int {
        return data.count
    }
}

struct ExamplesCellConfig {
    
    let title: String
}
