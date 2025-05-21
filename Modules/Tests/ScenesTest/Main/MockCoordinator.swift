import Foundation
import Models
import Scenes

final class MockCoordinator: MainViewModelCoordinatorDelegate {
    var selectedExchange: Exchange?

    func showDetailsScreen(for exchange: Exchange) {
        selectedExchange = exchange
    }
}
