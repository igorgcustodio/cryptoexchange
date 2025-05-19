import Foundation
import Testing
@testable import Networking

@Suite
struct RequestBuilderTests {
    struct MockBody: Codable, Equatable {
        let name: String
    }

    struct MockRoute: Networking.Route {
        var path: String = "/users"
        var method: Networking.Method = .POST
        var body: Encodable? = MockBody(name: "Igor")
        var headers: [String: String] = ["Authorization": "Bearer token"]
        var queryItems: [URLQueryItem] = [URLQueryItem(name: "role", value: "admin")]
        var timeout: TimeInterval = 120
        var cachePolicy: URLRequest.CachePolicy = .reloadRevalidatingCacheData
        var usesAbsoluteURL: Bool = false
    }

    @Test("buildRequest() returns a valid URLRequest for a well-formed route")
    func validRequest() throws {
        // Given
        let route = MockRoute()
        let baseUrl = "https://api.example.com"
        let builder = Networking.RequestBuilder(baseUrl: baseUrl, route: route)

        // When
        let request = try builder.buildRequest()

        // Then
        #expect(request.url?.absoluteString == "https://api.example.com/users?role=admin")
        #expect(request.httpMethod == "POST")
        #expect(request.timeoutInterval == 120)
        #expect(request.cachePolicy == .reloadRevalidatingCacheData)
        #expect(request.value(forHTTPHeaderField: "Authorization") == "Bearer token")

        if let body = request.httpBody {
            let decoded = try JSONDecoder().decode(MockBody.self, from: body)
            #expect(decoded == MockBody(name: "Igor"))
        } else {
            assertionFailure("this test should not fail")
        }
    }

    @Test("buildRequest() throws badUrl error for malformed base URL")
    func badURLThrows() {
        struct BadRoute: Networking.Route {
            var path: String = "/test"
            var method: Networking.Method = .GET
            var body: Encodable? = nil
            var headers: [String: String] = [:]
            var queryItems: [URLQueryItem] = []
            var timeout: TimeInterval = 30
            var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
            var usesAbsoluteURL: Bool = false
        }

        let route = BadRoute()
        let builder = Networking.RequestBuilder(baseUrl: "invalid", route: route)

        #expect(throws: Networking.RequestBuilder.RequestError.badUrl) {
            _ = try builder.buildRequest()
        }
    }
}
