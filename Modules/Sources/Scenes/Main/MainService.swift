import Foundation
import Models
import Networking

public protocol MainServiceProtocol: AnyObject {
    func fetchExchanges() async throws -> [Exchange]
}

public final class MainService: NetworkingService<ExchangeRoutes>, MainServiceProtocol {
    public func fetchExchanges() async throws -> [Exchange] {
        return try await request(.fetchAll)
     }
}
