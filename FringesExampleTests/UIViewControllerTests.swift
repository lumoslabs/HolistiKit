import XCTest
@testable import FringesExample

class UIViewControllerTests: FringesTest {

    func test_titleIsCorrect() {
        tapAppIcon()
        examplesUI.tapUIViewControllerRow()
        XCTAssertEqual(uiViewControllerUI.title, "UIViewController")
    }
}
