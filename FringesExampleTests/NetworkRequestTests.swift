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
        XCTAssertNil(networkRequestView.dataLabel)
        respond(to: .httpbin, with: .success(["Some key" : "Some value"]))
        XCTAssertEqual(networkRequestView.dataLabel, "Some key")
    }
}
