import XCTest
@testable import Models

final class EndpointProviderTests: XCTestCase {

    var subject: EndpointProvider!

    override func setUpWithError() throws {
        try super.setUpWithError()

        subject = EndpointProvider()
    }

    override func tearDownWithError() throws {
        subject = nil
        try super.tearDownWithError()
    }

    func test_configration_path_isEqualToExpectedValue() {
        let subject = subject.endpoint(from: .configuration)
        XCTAssertEqual(subject.url.path,"/3/configuration")
    }

    func test_popular_path_isEqualToExpectedValue() {
        let subject = subject.endpoint(from: .popular(.movie, page: 1))
        let expected = "/3/movie/popular"
        XCTAssertEqual(subject.url.path, expected)
    }
}
