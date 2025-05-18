import Combine
import Foundation

// MARK: - Protocol

public protocol MainViewModelProtocol: AnyObject {
    func fetchExchanges() async throws
}

// MARK: - View Model

@MainActor
public final class MainViewModel: MainViewModelProtocol {

    // MARK: - Properties

    private let service: MainServiceProtocol

    // MARK: - Initializer

    public init(service: MainServiceProtocol) {
        self.service = service

    }

    // MARK: - Methods

    public func fetchExchanges() async throws {
        do {
            let exchanges = try await service.fetchExchanges()
            print(exchanges)
        } catch {
            print(error)
        }
    }
}
