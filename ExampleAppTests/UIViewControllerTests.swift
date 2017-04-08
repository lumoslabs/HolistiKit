import XCTest
@testable import ExampleApp

class UIViewControllerTests: ExampleAppTestCase {

    func test_titleIsCorrect() {
        tapAppIcon()
        examplesUI.tapUIViewControllerRow()
        XCTAssertEqual(uiViewControllerUI.title, "UIViewController")
    }

    func test_canPresentAViewController() {
        tapAppIcon()
        examplesUI.tapUIViewControllerRow()
        let vc = uiViewControllerUI
        uiViewControllerUI.tapPresentViewController()
        XCTAssertNotNil(vc?.presentedViewController)
    }
}
