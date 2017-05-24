import UIKit

class Recorder {

    enum Event: CustomStringConvertible {
        case applicationDidLaunch
        case applicationWillResignActive
        case applicationDidEnterBackground
        case applicationWillEnterForeground
        case applicationDidBecomeActive
        case applicationWillTerminate
        case viewDidLoad(UIViewController)
        case viewWillDisappear(UIViewController)
        case viewWillAppear(UIViewController)
        case viewDidAppear(UIViewController)
        case viewDidDisappear(UIViewController)
        case notification(NSNotification.Name)
        case custom(String)

        var description: String {
            switch self {
            case .applicationDidLaunch: return "applicationDidLaunch"
            case .applicationWillResignActive: return "applicationWillResignActive"
            case .applicationDidEnterBackground: return "applicationDidEnterBackground"
            case .applicationWillEnterForeground: return "applicationWillEnterForeground"
            case .applicationDidBecomeActive: return "applicationDidBecomeActive"
            case .applicationWillTerminate: return "applicationWillTerminate"
            case .viewDidLoad(let vc): return "viewDidLoad(\(vc))"
            case .viewWillDisappear(let vc): return "viewWillDisappear(\(vc))"
            case .viewWillAppear(let vc): return "viewWillAppear(\(vc))"
            case .viewDidAppear(let vc): return "viewDidAppear(\(vc))"
            case .viewDidDisappear(let vc): return "viewDidDisappear(\(vc))"
            case .notification(let name): return "notification(\(name))"
            case .custom(let name): return "custom(\(name))"
            }
        }
    }

    private(set) var events = [Event]()

    func record(_ event: Event) {
        events.append(event)
    }

    func removeAllEvents() {
        events.removeAll()
    }
}

extension Recorder.Event: Equatable {}
func ==(lhs: Recorder.Event, rhs: Recorder.Event) -> Bool {
    switch (lhs, rhs) {
    case (.applicationDidLaunch, .applicationDidLaunch):
        return true
    case (.applicationWillResignActive, .applicationWillResignActive):
        return true
    case (.applicationDidEnterBackground, .applicationDidEnterBackground):
        return true
    case (.applicationWillEnterForeground, .applicationWillEnterForeground):
        return true
    case (.applicationDidBecomeActive, .applicationDidBecomeActive):
        return true
    case (.applicationWillTerminate, .applicationWillTerminate):
        return true
    case (.viewDidLoad(let subL), .viewDidLoad(let subR)):
        return subL == subR
    case (.viewWillDisappear(let subL), .viewWillDisappear(let subR)):
        return subL == subR
    case (.viewWillAppear(let subL), .viewWillAppear(let subR)):
        return subL == subR
    case (.viewDidAppear(let subL), .viewDidAppear(let subR)):
        return subL == subR
    case (.viewDidDisappear(let subL), .viewDidDisappear(let subR)):
        return subL == subR
    case (.custom(let idL), .custom(let idR)):
        return idL == idR
    case (.notification(let idL), .notification(let idR)):
        return idL == idR
    default:
        return false
    }
}
