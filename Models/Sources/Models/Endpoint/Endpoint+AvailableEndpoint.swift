import Foundation
import Networking

extension Endpoint {

    public enum AvailableEndpoint {
        case configuration
        case search(SearchParameter)
        case popular(EndpointCategory, page: Int)
        case details(EndpointCategory, id: String)
        case images(path: String, width: String)
    }

    static var configuration: Endpoint {
        Endpoint(url: url(path: "configuration"),
                 tokenRequirement: .notRequired)
    }

    static func search(parameter: SearchParameter) -> Endpoint {
        let url = url(path: "\(parameter.category.rawValue)/popular",
                      queryParams: [
                        "query": parameter.query,
                        "include_adult": parameter.includeAdult ? "true" : "false",
                        "page": "\(parameter.page)",
                      ])
        return Endpoint(url: url,
                        tokenRequirement: .notRequired)
    }

    static func popular(category: EndpointCategory, page: Int = 1) -> Endpoint {
        Endpoint(url: url(path: "\(category.rawValue)/popular",
                          queryParams: [
                            "page": "\(page)"
                          ]),
                 tokenRequirement: .notRequired)
    }

    static func details(category: EndpointCategory, id: String) -> Endpoint {
        Endpoint(url: url(path: "\(category.rawValue)/popular",
                          queryParams: [
                            "\(category)_id": id
                          ]),
                 tokenRequirement: .notRequired)
    }

    static func image(path: String, width: String) -> Endpoint {
        #warning("TODO: load image base url from configuration api")
        let imageBaseUri = "https://image.tmdb.org/t/p"
        guard let url = URL(string: "\(imageBaseUri)/\(width)\(path)") else {
            fatalError("The Image url is not correct")
        }
        return Endpoint(url: url, tokenRequirement: .notRequired)
    }
}

extension Endpoint {

    static let baseURL = "https://api.themoviedb.org"
    static let apiVersion = "/3"
    static let apiKey = "78e166975326fe880c913ca18bfdea1e"

    static var defaultQueryParams: [String: String?] {
        [
            "api_key": apiKey,
            "language": "en",
            "region": "GB"
        ]
    }

    /// To create url with parameters dicationary, give client more
    /// flexiable with multiple parameters request.
    /// - Parameters:
    ///   - path: base path of the API, e.g. `/configuration`
    ///   - queryParams: request parameters.
    /// - Returns: a URL object.
    static private func url(
        path: String,
        queryParams: [String: String?] = [:]
    ) -> URL {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = apiVersion + "/\(path)"
        urlComponents?.queryItems = queryParams
            .merging(defaultQueryParams) { _, new in new }
            .compactMap {
                guard let value = $0.value else { return nil }
                return URLQueryItem(name: $0.key, value: value)
            }

        guard let url = urlComponents?.url  else {
            fatalError("Unable to create URL with path \(path)")
        }

#if DEBUG
        print(url)
#endif

        return url
    }
}
