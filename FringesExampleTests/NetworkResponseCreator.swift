import Foundation

class NetworkResponseCreator {

    class func data(from json: Any) -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        } catch {
            fatalError("Couldn't create JSON.")
        }
    }
}
