import UIKit

class Recorder {

    enum Event {
        case viewDidLoad(UIViewController)
        case viewWillDisappear(UIViewController)
        case viewWillAppear(UIViewController)
        case viewDidAppear(UIViewController)
        case viewDidDisappear(UIViewController)
        case custom(String)
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
    case (.custom(let idL), .custom(let idR)):
        return idL == idR
    default:
        return false
    }
}
