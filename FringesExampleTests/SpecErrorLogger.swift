@testable import FringesExample

class SpecErrorLogger: ErrorLogging {
    
    func log(_ message: String) {
        fatalError(message)
    }
}
