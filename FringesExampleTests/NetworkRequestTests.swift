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
        respond(to: .httpbin, with: ["Some key" : "Some value"])
        XCTAssertEqual(networkRequestView.dataLabel, "Some key")
    }

    func test_theNetworkActivityIndicatorIsShown() {
        tapAppIcon()
        XCTAssertFalse(networkActivityIndicatorIsVisible)
        examples.tapNetworkRequestRow()
        XCTAssertTrue(networkActivityIndicatorIsVisible)
        respond(to: .httpbin, with: [:])
        XCTAssertFalse(networkActivityIndicatorIsVisible)
    }

    func test_theNetworkActivityIndicatorIsRemovedWhenTappingBack() {
        tapAppIcon()
        XCTAssertFalse(networkActivityIndicatorIsVisible)
        examples.tapNetworkRequestRow()
        XCTAssertTrue(networkActivityIndicatorIsVisible)
        navigationController.tapBack()
        XCTAssertFalse(networkActivityIndicatorIsVisible)
    }
}
