import XCTest
import SnapshotTesting
import SwiftUI

@testable import Home
@testable import Models

final class HomeViewRenderTests: XCTestCase {

    private var store: HomeStore!

    override func setUpWithError() throws {
        try super.setUpWithError()

        store = .init(initial: HomeState(),
                      reducer: homeReducer,
                      environment: HomeRepository(),
                      middlewares: [homeMiddleware])
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_homeView_layout_isEqualExpected() {
        store.dispatch(.didLoadPopularMovies(PopularMovieResponse.arrange.results))
        store.dispatch(.didLoadPopularTVs(PopularTVResponse.arrange.results))
        
        let view = HomeView()
            .environmentObject(store)
        let viewController = UIHostingController(rootView: view)
        assertSnapshot(matching: viewController, as: .image(on: .iPhone8))
    }
}
