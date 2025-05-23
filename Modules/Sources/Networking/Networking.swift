import Foundation

public enum Networking {
    public enum Method: String {
        case GET, POST, PUT, DELETE
    }

    public protocol Route {
        var path: String { get }
        var method: Method { get }
        var body: Encodable? { get }
        var headers: [String: String] { get }
        var queryItems: [URLQueryItem] { get }
        var timeout: TimeInterval { get }
        var cachePolicy: URLRequest.CachePolicy { get }
        var usesAbsoluteURL: Bool { get }
    }

    public enum ResponseError: Error {
        case noResponse
        case unexpected
        case decodingFailed(underlyingError: Error)
        case clientError(code: Int)
        case serverError(code: Int)
        case unkonwn(description: String)

        public var localizedDescription: String {
            switch self {
            case let .clientError(code):
                return "Client error (\(code))"
            case let .serverError(code):
                return "Server error (\(code))"
            case let .unkonwn(description):
                return description
            case .noResponse:
                return "Failed to convert the URLResponse"
            case .unexpected:
                return "Unexpected error"
            case .decodingFailed:
                return "Failed to decode"
            }
        }
    }

    public struct RequestBuilder {
        let baseUrl: String
        let route: Route

        public enum RequestError: Error {
            case badUrl
            case encodingFailed
            case invalidQueryItems
        }

        func buildRequest(defaultHeaders: [String: String] = DefaultHeaders.headers) throws -> URLRequest {
            guard var url = URL(string: baseUrl + route.path),
                  let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                  let scheme = components.scheme?.lowercased(),
                  ["http", "https"].contains(scheme),
                  let host = components.host, !host.isEmpty
            else {
                throw RequestError.badUrl
            }

            if !route.queryItems.isEmpty {
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                components?.queryItems = route.queryItems

                if let componentUrl = components?.url {
                    url = componentUrl
                } else {
                    throw RequestError.invalidQueryItems
                }
            }

            var request = URLRequest(
                url: url,
                cachePolicy: route.cachePolicy,
                timeoutInterval: route.timeout
            )

            request.httpMethod = route.method.rawValue

            for header in defaultHeaders {
                request.setValue(header.value, forHTTPHeaderField: header.key)
            }

            for header in route.headers {
                request.setValue(header.value, forHTTPHeaderField: header.key)
            }

            if route.method != .GET, let body = route.body {
                do {
                    let data = try JSONEncoder().encode(body)
                    request.httpBody = data
                } catch {
                    throw RequestError.encodingFailed
                }
            }

            return request
        }
    }
}

extension Networking.Route {
    public var timeout: TimeInterval { 60 }
    public var cachePolicy: URLRequest.CachePolicy { .reloadIgnoringLocalCacheData }
}
