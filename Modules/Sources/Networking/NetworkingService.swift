import Foundation

public typealias NetworkingService = Networking.NetworkingService

extension Networking {
    open class NetworkingService<R: Route> {
        let urlSession: URLSessionProtocol
        let baseUrl: String

        public init(urlSession: URLSessionProtocol = URLSession.shared, baseUrl: String = KeyConfig.baseURL) {
            self.urlSession = urlSession
            self.baseUrl = baseUrl
        }

        public func request<T: Decodable>(_ route: R) async throws -> T {
            let data: Data? = try await request(route)

            guard let data else {
                throw ResponseError.unexpected
            }

            do {
                return try await Task.detached {
                    return try JSONDecoder().decode(T.self, from: data)
                }.value
            } catch let error as DecodingError {
                throw ResponseError.decodingFailed(underlyingError: error)
            } catch {
                throw ResponseError.unexpected
            }
        }

        public func request(_ route: R) async throws -> Data? {
            let requestBuilder = RequestBuilder(baseUrl: route.usesAbsoluteURL ? "" : baseUrl, route: route)

            let request = try requestBuilder.buildRequest()

            let (data, response) = try await urlSession.data(for: request)

            guard let response = response as? HTTPURLResponse else {
                throw ResponseError.noResponse
            }

            switch response.statusCode {
            case 200..<300:
                return data
            case 400..<500:
                throw ResponseError.clientError(code: response.statusCode)
            case 500..<600:
                throw ResponseError.serverError(code: response.statusCode)
            default:
                throw ResponseError.unexpected
            }

        }
    }
}
