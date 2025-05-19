import Foundation

public enum ExchangeRoutes: Networking.Route {
    case fetchAll

    public var path: String {
        switch self {
        case .fetchAll:
            "exchanges"
        }
    }

    public var method: Networking.Method {
        .GET
    }

    public var body: Encodable? {
        nil
    }

    public var headers: [String: String] {
        [:]
    }

    public var queryItems: [URLQueryItem] {
        []
    }

    public var usesAbsoluteURL: Bool {
        false
    }
}
