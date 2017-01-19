import XCTest
@testable import FringesExample

class NetworkRequestTests: FringesTest {

    func test_titleIsCorrect() {
        tapAppIcon()
        examples.tapNetworkRequestRow()
        XCTAssertEqual(networkRequestView.title, "Network Request")
    }

    func test_theRequestDataIsShownUponSuccess() {
        tapAppIcon()
        examples.tapNetworkRequestRow()
        respond(to: .httpbin, with: .success(["Some key" : "Some value"]))
    }
}
