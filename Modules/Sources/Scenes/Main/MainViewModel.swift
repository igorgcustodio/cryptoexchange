import Combine
import CoreUI
import Foundation
import Models

// MARK: - Protocols

@MainActor
public protocol MainViewModelCoordinatorDelegate: AnyObject {
    func showDetailsScreen(for exchange: Exchange)
}

@MainActor
public protocol MainViewModelProtocol: AnyObject {
    var events: PassthroughSubject<MainViewModelState, Never> { get }
    var numberOfSections: Int { get }

    func numberOfItems(at section: Int) -> Int
    func item(at indexPath: IndexPath) -> MainTableViewDataRow

    func fetchExchanges() async throws
    func didSelectRow(at indexPath: IndexPath)
}

// MARK: - State

public enum MainViewModelState: Sendable, Equatable {
    case loading
    case loaded
    case failed(String)
}

// MARK: - View Model

@MainActor
public final class MainViewModel: ObservableObject {
    // MARK: - Properties

    private let service: MainServiceProtocol
    private var tableViewData: MainTableViewData
    private var exchanges: [Exchange] = [] {
        didSet {
            tableViewData.clearData()
            tableViewData.add(
                sections: TableViewDataSection(
                    rows: exchanges.map { .exchange($0) },
                    type: .exchanges,
                    visible: true
                )
            )
            events.send(.loaded)
        }
    }

    public var events = PassthroughSubject<MainViewModelState, Never>()
    private weak var coordinatorDelegate: MainViewModelCoordinatorDelegate?

    // MARK: - Initializer

    public init(
        service: MainServiceProtocol,
        coordinatorDelegate: MainViewModelCoordinatorDelegate?
    ) {
        self.service = service
        self.coordinatorDelegate = coordinatorDelegate
        tableViewData = MainTableViewData()
    }
}

// MARK: - MainViewModelProtocol

extension MainViewModel: MainViewModelProtocol {
    public var numberOfSections: Int { tableViewData.sectionCount }

    public func numberOfItems(at section: Int) -> Int {
        tableViewData.visibleSections[section].rows.count
    }

    public func item(at indexPath: IndexPath) -> MainTableViewDataRow {
        tableViewData.visibleSections[indexPath.section].rows[indexPath.row]
    }

    public func fetchExchanges() async throws {
        do {
            events.send(.loading)
            exchanges = try await service.fetchExchanges()
        } catch {
            events.send(.failed("Failed to fetch exchanges"))
        }
    }

    public func didSelectRow(at indexPath: IndexPath) {
        coordinatorDelegate?.showDetailsScreen(for: exchanges[indexPath.row])
    }
}
