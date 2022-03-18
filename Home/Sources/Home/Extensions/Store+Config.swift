import SwiftUI
import SwiftRedux

struct StoreModifier: ViewModifier {

    static var storeConfig = StoreConfig.shared

    static var store: HomeStore {
        Self.storeConfig.store
    }

    func body(content: Content) -> some View {
        content
            .environmentObject(Self.store)
    }
}

final class StoreConfig {

    static let shared: StoreConfig = .init()

    let store: HomeStore

    init() {
        self.store = HomeStore(initial: .init(),
                               reducer: homeReducer,
                               environment: .init() ,
                               middlewares: [homeMiddleware])
    }
}

