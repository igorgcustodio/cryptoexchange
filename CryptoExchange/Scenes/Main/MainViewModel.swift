import Combine
import Foundation

// MARK: - Protocol

protocol MainViewModelProtocol: AnyObject {
    func fetchExchanges() async throws
}

// MARK: - View Model

@MainActor
final class MainViewModel: MainViewModelProtocol {

    // MARK: - Properties

    // MARK: - Initializer

    init() {

    }

    // MARK: - Methods

    func fetchExchanges() async throws {

    }
}
