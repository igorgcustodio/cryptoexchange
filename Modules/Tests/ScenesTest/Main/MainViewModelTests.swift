import Combine
import Foundation
import Models
import Testing

@testable import Scenes

@Suite
@MainActor
struct MainViewModelTests {

    @Test
    func fetchExchanges_success() async throws {
        let mockService = MockMainServiceProtocol(result: .success([.mock()]))
        let mockCoordinator = MockCoordinator()
        let viewModel = MainViewModel(service: mockService, coordinatorDelegate: mockCoordinator)

        var states: [MainViewModelState] = []
        let cancellable = viewModel.events.sink { states.append($0) }

        try await viewModel.fetchExchanges()

        #expect(states.first == .loading)
        #expect(states.last == .loaded)

        #expect(viewModel.numberOfSections == 1)
        #expect(viewModel.numberOfItems(at: 0) == 1)

        cancellable.cancel()
    }

    @Test
    func fetchExchanges_failed() async throws {
        enum MockError: Error { case test }

        let mockService = MockMainServiceProtocol(result: .failure(MockError.test))
        let mockCoordinator = MockCoordinator()
        let viewModel = MainViewModel(service: mockService, coordinatorDelegate: mockCoordinator)

        var receivedStates: [MainViewModelState] = []
        let cancellable = viewModel.events.sink { receivedStates.append($0) }

        try? await viewModel.fetchExchanges()

        #expect(receivedStates.contains(.failed("Failed to fetch exchanges")))

        cancellable.cancel()
    }

    @Test
    func didSelectRow_openScreen() async {
        let exchange = Exchange.mock(id: "coinbase")
        let mockService = MockMainServiceProtocol(result: .success([exchange]))
        let mockCoordinator = MockCoordinator()
        let viewModel = MainViewModel(service: mockService, coordinatorDelegate: mockCoordinator)

        try? await viewModel.fetchExchanges()
        viewModel.didSelectRow(at: IndexPath(row: 0, section: 0))

        #expect(mockCoordinator.selectedExchange?.exchangeId == "coinbase")
    }
}
