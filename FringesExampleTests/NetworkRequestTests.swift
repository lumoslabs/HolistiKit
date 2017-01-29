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
        networkRequestUI.tapRequestJSON()
        XCTAssertEqual(networkRequestUI.dataLabel,
                       SpecNetworkRequestViewController.DataLabel(text: "", animated: false))
        respond(to: .httpbin, with: ["Some key" : "Some value"])
        XCTAssertEqual(networkRequestUI.dataLabel, 
                       SpecNetworkRequestViewController.DataLabel(text: "[\"Some key\": Some value]", animated: true))
    }

    func test_theNetworkActivityIndicatorIsShown() {
        tapAppIcon()
        XCTAssertFalse(networkActivityIndicatorIsVisible)
        examplesUI.tapNetworkRequestRow()
        networkRequestUI.tapRequestJSON()
        XCTAssertTrue(networkActivityIndicatorIsVisible)
        respond(to: .httpbin, with: [:])
        XCTAssertFalse(networkActivityIndicatorIsVisible)
    }

    func test_theNetworkActivityIndicatorIsRemovedWhenTappingBack() {
        tapAppIcon()
        XCTAssertFalse(networkActivityIndicatorIsVisible)
        examplesUI.tapNetworkRequestRow()
        networkRequestUI.tapRequestJSON()
        XCTAssertTrue(networkActivityIndicatorIsVisible)
        navigationController.tapBack()
        XCTAssertFalse(networkActivityIndicatorIsVisible)
    }
}
