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

    // MARK: - Initializer

    public init() {

    }

    // MARK: - Methods

    public func fetchExchanges() async throws {

    }
}
