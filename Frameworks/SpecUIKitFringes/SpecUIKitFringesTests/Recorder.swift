import UIKit

class Recorder {

    enum Event {
        case viewDidLoad(UIViewController)
        case viewWillDisappear(UIViewController)
        case viewWillAppear(UIViewController)
        case viewDidAppear(UIViewController)
        case viewDidDisappear(UIViewController)
        case pushViewController(UINavigationController, UIViewController)
        case setViewControllers(UINavigationController, [UIViewController])
    }

    var events = [Event]()

    func record(_ event: Event) {
        events.append(event)
    }
}

extension Recorder.Event: Equatable {}
func ==(lhs: Recorder.Event, rhs: Recorder.Event) -> Bool {
    switch (lhs, rhs) {
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
    case (.pushViewController(let navL, let vcL), .pushViewController(let navR, let vcR)):
        return navL == navR && vcL == vcR
    case (.setViewControllers(let navL, let vcL), .setViewControllers(let navR, let vcR)):
        return navL == navR && vcL == vcR
    default:
        return false
    }
}
