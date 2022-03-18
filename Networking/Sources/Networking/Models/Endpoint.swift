import Foundation

public struct Endpoint {

    public enum TokenRequirement {
        case required
        case notRequired
        case requested
    }

    public init(url: URL, tokenRequirement: TokenRequirement) {
        self.url = url
        self.tokenRequirement = tokenRequirement
    }

    public var url: URL
    public var tokenRequirement: TokenRequirement

}

extension Endpoint: Equatable {

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.tokenRequirement == rhs.tokenRequirement
        && lhs.url == rhs.url
    }
}
