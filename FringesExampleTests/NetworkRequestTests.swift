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
        XCTAssertFalse(networkActivityIndicatorIsVisible)
        examples.tapNetworkRequestRow()
        XCTAssertTrue(networkActivityIndicatorIsVisible)
        XCTAssertNil(networkRequestView.dataLabel)
        respond(to: .httpbin, with: .success(["Some key" : "Some value"]))
        XCTAssertFalse(networkActivityIndicatorIsVisible)
        XCTAssertEqual(networkRequestView.dataLabel, "Some key")
    }
}
