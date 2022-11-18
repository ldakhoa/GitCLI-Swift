import XCTest
@testable import swift_gitcli

final class swift_gitcliTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(swift_gitcli().text, "Hello, World!")
    }
}
