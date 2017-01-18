import XCTest

class ExamplesTests: FringesTest {

    func test_titleIsCorrect() {
        tapAppIcon()
        XCTAssertEqual(examples.title, "Examples")
    }

    func test_rowsAreCorrectlyConfigured() {
        tapAppIcon()
        let expectedRows: [(String, UITableViewCellAccessoryType)] = [
            ("Date", .disclosureIndicator),
            ("Timer", .disclosureIndicator),
            ("Network Request", .disclosureIndicator)
        ]
        XCTAssertEqual(examples.numberOfRows, expectedRows.count)
        expectedRows.enumerated().forEach { index, row in
            XCTAssertEqual(examples.title(forRow: index), row.0)
            XCTAssertEqual(examples.accessoryIndicator(forRow: index), row.1)
        }
    }

    func test_canNavigateToTheDatePage() {
        tapAppIcon()
        examples.tapDateRow()
        XCTAssertNotNil(date)
    }
}
