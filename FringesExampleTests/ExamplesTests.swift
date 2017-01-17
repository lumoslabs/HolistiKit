import XCTest

class ExamplesTests: FringesTest {

    func test_titleIsCorrect() {
        tapAppIcon()
        XCTAssertEqual(examples.title, "Examples")
    }

    func test_rowsAreCorrectlyConfigured() {
        tapAppIcon()
        let expectedTitles = [ "Date", "Timer" ]
        XCTAssertEqual(examples.numberOfRows, expectedTitles.count)
        expectedTitles.enumerated().forEach {
            XCTAssertEqual(examples.title(forRow: $0), $1)
        }
    }

    func test_canNavigateToTheDatePage() {
        tapAppIcon()
        examples.tapDateRow()
        XCTAssertNotNil(date)
    }
}
