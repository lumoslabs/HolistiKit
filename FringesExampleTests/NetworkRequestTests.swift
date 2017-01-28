import XCTest
@testable import FringesExample

class NetworkRequestTests: FringesTest {

    func test_titleIsCorrect() {
        tapAppIcon()
        examplesUI.tapNetworkRequestRow()
        XCTAssertEqual(networkRequestUI.title, "Network Request")
    }

    func test_theRequestDataIsShownUponSuccess() {
        tapAppIcon()
        examplesUI.tapNetworkRequestRow()
        XCTAssertEqual(networkRequestUI.dataLabel, "")
        respond(to: .httpbin, with: ["Some key" : "Some value"])
        XCTAssertEqual(networkRequestUI.dataLabel, "[\"Some key\": Some value]")
    }

    func test_theNetworkActivityIndicatorIsShown() {
        tapAppIcon()
        XCTAssertFalse(networkActivityIndicatorIsVisible)
        examplesUI.tapNetworkRequestRow()
        XCTAssertTrue(networkActivityIndicatorIsVisible)
        respond(to: .httpbin, with: [:])
        XCTAssertFalse(networkActivityIndicatorIsVisible)
    }

    func test_theNetworkActivityIndicatorIsRemovedWhenTappingBack() {
        tapAppIcon()
        XCTAssertFalse(networkActivityIndicatorIsVisible)
        examplesUI.tapNetworkRequestRow()
        XCTAssertTrue(networkActivityIndicatorIsVisible)
        navigationController.tapBack()
        XCTAssertFalse(networkActivityIndicatorIsVisible)
    }
}
