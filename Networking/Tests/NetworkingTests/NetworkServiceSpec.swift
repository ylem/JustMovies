import XCTest
import Quick
import Nimble
import Combine

@testable import Networking
@testable import NetworkingMocks

final class NetworkServiceSpec: QuickSpec {

    override func spec() {

        var networkService: NetworkService!
        var session: MockNetworkSession!
        var cancellables: [AnyCancellable] = []

        beforeEach {
            session = MockNetworkSession()
            networkService = NetworkService(urlSession: session)
        }

        func configureSession(with statusCode: Int?, data: Data?, error: HTTPError?) {
            session.statusCode = statusCode ?? 200
            session.data = data
            session.error = error
        }

        func requestError(
            matches expectedError: Error,
            using requestData: RequestData = .default,
            done: @escaping () -> Void
        ) {
            networkService.request(requestData: requestData)
                .sink { completion in
                    if case .failure(let error) = completion {
                        expect(error).to(matchError(expectedError))
                        done()
                    } else {
                        fail("result should be failure")
                    }
                } receiveValue: { (object: NoReply) in
                    fail("result should be failure")
                }
                .store(in: &cancellables)
        }

        describe("network service") {

            context("unauthorised error") {
                it("request returns failure with unauthorised error") {
                    configureSession(with: 401, data: nil, error: HTTPError.unauthorised)
                    let expectedError = HTTPError.unauthorised

                    waitUntil { done in
                        requestError(matches: expectedError, done: done)
                    }
                }
            }

            context("bad request error") {
                it("request returns failure with with bad request error") {
                    let expectedError = HTTPError.failedWithStatusCode(.badRequest)
                    configureSession(with: 400, data: nil, error: expectedError)

                    waitUntil { done in
                        requestError(matches: expectedError, done: done)
                    }
                }
            }

            context("internal server error") {
                it("request returns failure with with internal server error") {
                    let expectedError = HTTPError.failedWithStatusCode(.internalError)
                    configureSession(with: 500, data: nil, error: expectedError)

                    waitUntil { done in
                        requestError(matches: expectedError, done: done)
                    }
                }
            }

            context("not found error") {
                it("request returns failure with with not found error") {
                    let expectedError = HTTPError.failedWithStatusCode(.notFound)
                    configureSession(with: 404, data: nil, error: expectedError)

                    waitUntil { done in
                        requestError(matches: expectedError, done: done)
                    }
                }
            }

            context("unmapped error") {
                it("request returns failure with with unknown error code") {
                    configureSession(with: 743, data: nil, error: nil)
                    let expectedError = HTTPError.unknownErrorCode

                    waitUntil { done in
                        requestError(matches: expectedError, done: done)
                    }
                }
            }

        }
    }

}
