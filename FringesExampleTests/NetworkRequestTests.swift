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
        let json = ["Some key" : "Some value"]
        let data = NetworkResponseCreator.data(from: json)
        respond(to: .httpbin, with: .success(data))
        XCTAssertEqual(networkRequestView.dataLabel, "Some key")
    }

    func test_theNetworkActivityIndicatorIsShown() {
        tapAppIcon()
        XCTAssertFalse(networkActivityIndicatorIsVisible)
        examples.tapNetworkRequestRow()
        XCTAssertTrue(networkActivityIndicatorIsVisible)
        let data = NetworkResponseCreator.data(from: [:])
        respond(to: .httpbin, with: .success(data))
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
