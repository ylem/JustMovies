import Foundation

public struct SearchParameter {
    let category: EndpointCategory
    let query: String
    let includeAdult: Bool
    let page: Int
}
