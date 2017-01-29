import XCTest
@testable import FringesExample

class NetworkRequestTests: FringesTest {

    func test_titleIsCorrect() {
        tapAppIcon()
        examplesUI.tapNetworkRequestRow()
        XCTAssertEqual(networkRequestUI.title, "Network Request")
    }

    func test_jsonIsShownUponSuccess() {
        tapAppIcon()
        examplesUI.tapNetworkRequestRow()
        XCTAssertEqual(networkRequestUI.dataLabel,
                       SpecNetworkRequestViewController.DataLabel(text: "", animated: false))
        networkRequestUI.tapRequestJSON()
        respond(to: .json, with: ["Some key" : "Some value"])
        XCTAssertEqual(networkRequestUI.dataLabel, 
                       SpecNetworkRequestViewController.DataLabel(text: "[\"Some key\": Some value]", animated: true))
    }

    func test_htmlIsShownUponSuccess() {
        tapAppIcon()
        examplesUI.tapNetworkRequestRow()
        XCTAssertEqual(networkRequestUI.dataLabel,
                       SpecNetworkRequestViewController.DataLabel(text: "", animated: false))
        networkRequestUI.tapRequestHTML()
        respond(to: .html, with: "<p>hello world</p>")
        XCTAssertEqual(networkRequestUI.dataLabel, 
                       SpecNetworkRequestViewController.DataLabel(text: "<p>hello world</p>", animated: true))
    }

    func test_theNetworkActivityIndicatorIsShown() {
        tapAppIcon()
        XCTAssertFalse(networkActivityIndicatorIsVisible)
        examplesUI.tapNetworkRequestRow()
        networkRequestUI.tapRequestJSON()
        XCTAssertTrue(networkActivityIndicatorIsVisible)
        respond(to: .json, with: [:])
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
