import UIKit

class RecordingUINavigationController: UINavigationController {

    let recorder: Recorder

    init(recorder: Recorder) {
        self.recorder = recorder
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() { record(.viewDidLoad(self)) }
    override func viewDidDisappear(_ animated: Bool) { record(.viewDidDisappear(self)) }
    override func viewDidAppear(_ animated: Bool) { record(.viewDidAppear(self)) }
    override func viewWillAppear(_ animated: Bool) { record(.viewWillAppear(self)) }
    override func viewWillDisappear(_ animated: Bool) { record(.viewWillDisappear(self)) }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        record(.pushViewController(self, viewController))
        super.pushViewController(viewController, animated: animated)
    }

    private func record(_ event: Recorder.Event) { recorder.record(event) }
    required init?(coder aDecoder: NSCoder) { fatalError() }
}
