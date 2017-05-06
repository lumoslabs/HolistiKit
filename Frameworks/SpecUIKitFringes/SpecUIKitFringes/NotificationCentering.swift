import Foundation

protocol NotificationCentering {
    
    func post(name: NSNotification.Name, object: Any?)
}

extension NotificationCenter: NotificationCentering {}
