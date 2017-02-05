import UIKitFringes

protocol PushedPresenter {

    func push(on presenter: PushingPresenter)
    var viewControlling: ViewControlling { get }
}

extension PushedPresenter {

    func push(on presenter: PushingPresenter) {
        presenter.push(viewController: viewControlling)
    }
}
