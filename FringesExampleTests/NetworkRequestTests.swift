import XCTest
@testable import FringesExample

class URLSessionTests: FringesTest {

    func test_titleIsCorrect() {
        tapAppIcon()
        examplesUI.tapURLSessionRow()
        XCTAssertEqual(urlSessionUI.title, "URLSession")
    }

    func test_jsonIsShownUponSuccess() {
        tapAppIcon()
        examplesUI.tapURLSessionRow()
        XCTAssertEqual(urlSessionUI.dataLabel,
                       SpecURLSessionViewController.DataLabel(text: "", animated: false))
        urlSessionUI.tapRequestJSON()
        respond(to: .json, with: ["Some key" : "Some value"])
        XCTAssertEqual(urlSessionUI.dataLabel, 
                       SpecURLSessionViewController.DataLabel(text: "[\"Some key\": Some value]", animated: true))
    }

    func test_htmlIsShownUponSuccess() {
        tapAppIcon()
        examplesUI.tapURLSessionRow()
        XCTAssertEqual(urlSessionUI.dataLabel,
                       SpecURLSessionViewController.DataLabel(text: "", animated: false))
        urlSessionUI.tapRequestHTML()
        respond(to: .html, with: "<p>hello world</p>")
        XCTAssertEqual(urlSessionUI.dataLabel, 
                       SpecURLSessionViewController.DataLabel(text: "<p>hello world</p>", animated: true))
    }

    func test_theNetworkActivityIndicatorIsShown() {
        tapAppIcon()
        XCTAssertFalse(networkActivityIndicatorIsVisible)
        examplesUI.tapURLSessionRow()
        urlSessionUI.tapRequestJSON()
        XCTAssertTrue(networkActivityIndicatorIsVisible)
        respond(to: .json, with: [:])
        XCTAssertFalse(networkActivityIndicatorIsVisible)
    }

    func test_theNetworkActivityIndicatorIsRemovedWhenTappingBack() {
        tapAppIcon()
        XCTAssertFalse(networkActivityIndicatorIsVisible)
        examplesUI.tapURLSessionRow()
        urlSessionUI.tapRequestJSON()
        XCTAssertTrue(networkActivityIndicatorIsVisible)
        navigationController.tapBack()
        XCTAssertFalse(networkActivityIndicatorIsVisible)
    }
}
