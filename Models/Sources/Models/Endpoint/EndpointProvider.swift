import Foundation
import Networking

public protocol EndpointProviding {
    func endpoint(from availableEndpoint: Endpoint.AvailableEndpoint) -> Endpoint
}

public class EndpointProvider: EndpointProviding  {

    public init() {}

    public func endpoint(from availableEndpoint: Endpoint.AvailableEndpoint) -> Endpoint {
        switch availableEndpoint {
        case .configuration:
            return Endpoint.configuration
        case .search(let parameter):
            return Endpoint.search(parameter: parameter)
        case .popular(let category, let page):
            return Endpoint.popular(category: category, page: page)
        case .details(let category, let id):
            return Endpoint.details(category: category, id: id)
        case .images(let path, let width):
            return Endpoint.image(path: path, width: width)
        }
    }
}

