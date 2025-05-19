import Foundation
import Testing
@testable import Networking

@Suite
struct NetworkingServiceTests {
    struct MockRoute: Networking.Route {
        let path: String = "/users/1"
        let method: Networking.Method = .GET
        let body: Encodable? = nil
        var headers: [String: String] = [:]
        var queryItems: [URLQueryItem] = []
        let usesAbsoluteURL: Bool = false
    }

    class MockSession: URLSessionProtocol {
        var dataResult: (Data, URLResponse)?
        var error: Error?

        func data(for request: URLRequest) async throws -> (Data, URLResponse) {
            if let error {
                throw error
            }
            if let (data, response) = dataResult {
                return (data, response)
            }
            return (Data(), URLResponse(url: request.url!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil))
        }
    }

    @Test("Successful response returns decoded model")
    func successfulDecoding() async throws {
        struct User: Codable, Equatable {
            let id: Int
        }
        let expected = User(id: 1)
        let data = try JSONEncoder().encode(expected)
        let response = HTTPURLResponse(
            url: URL(string: "http://example.com/users/1")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!

        let session = MockSession()
        session.dataResult = (data, response)
        let service = NetworkingService<MockRoute>(urlSession: session, baseUrl: "http://example.com")

        let result: User = try await service.request(MockRoute())
        #expect(result == expected)
    }

    @Test("Non-HTTPURLResponse throws noResponse error")
    func noResponseError() async throws {
        let data = Data()
        let nonHTTPResponse = URLResponse(
            url: URL(string: "http://example.com")!,
            mimeType: nil,
            expectedContentLength: 0,
            textEncodingName: nil
        )

        let session = MockSession()
        session.dataResult = (data, nonHTTPResponse)
        let service = NetworkingService<MockRoute>(urlSession: session, baseUrl: "http://example.com")

        do {
            _ = try await service.request(MockRoute())
            #expect(false, "Expected noResponse error")
        } catch let error as Networking.ResponseError {
            #expect(error.localizedDescription == Networking.ResponseError.noResponse.localizedDescription)
        }
    }

    @Test("4xx status throws clientError")
    func testClientError() async throws {
        let data = Data()
        let response = HTTPURLResponse(
            url: URL(string: "http://example.com")!,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )!

        let session = MockSession()
        session.dataResult = (data, response)
        let service = NetworkingService<MockRoute>(urlSession: session, baseUrl: "http://example.com")

        do {
            _ = try await service.request(MockRoute())
            #expect(false, "Expected clientError error")
        } catch let error as Networking.ResponseError {
            if case let .clientError(code) = error {
                #expect(code == 404)
            } else {
                #expect(false, "Expected clientError but got \(error)")
            }
        }
    }

    @Test("5xx status throws serverError")
    func testServerError() async throws {
        let data = Data()
        let response = HTTPURLResponse(
            url: URL(string: "http://example.com")!,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )!

        let session = MockSession()
        session.dataResult = (data, response)
        let service = NetworkingService<MockRoute>(urlSession: session, baseUrl: "http://example.com")

        do {
            _ = try await service.request(MockRoute())
            #expect(false, "Expected serverError error")
        } catch let error as Networking.ResponseError {
            if case let .serverError(code) = error {
                #expect(code == 500)
            } else {
                #expect(false, "Expected serverError but got \(error)")
            }
        }
    }

    @Test("Decoding invalid data throws decodingFailed error")
    func testDecodingFailed() async throws {
        struct User: Codable, Equatable {
            let id: Int
        }

        let invalidData = Data("invalid json".utf8)
        let response = HTTPURLResponse(
            url: URL(string: "http://example.com/users/1")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!

        let session = MockSession()
        session.dataResult = (invalidData, response)
        let service = NetworkingService<MockRoute>(urlSession: session, baseUrl: "http://example.com")

        do {
            let _: User = try await service.request(MockRoute())
            assertionFailure("This test should not pass")
        } catch let error as Networking.ResponseError {
            if case .decodingFailed = error {
                #expect(true)
            } else {
                assertionFailure("Expected decodingFailed but got \(error)")
            }
        }
    }
}
