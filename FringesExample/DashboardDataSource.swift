import Foundation

class DashboardDataSource {

    private let data = [
        DashboardCellConfig(title: "Settings")
    ]
    
    func cellConfiguration(for indexPath: IndexPath) -> DashboardCellConfig {
        let row = indexPath.row
        return data[row]
    }

    var numberOfRows: Int {
        return data.count
    }
}

struct DashboardCellConfig {
    
    let title: String
}
