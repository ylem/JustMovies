import Foundation

extension HomeStore {

    static var preview: HomeStore {
        .init(initial: .init(),
              reducer: homeReducer,
              environment: .init() ,
              middlewares: [homeMiddleware])
    }
}
