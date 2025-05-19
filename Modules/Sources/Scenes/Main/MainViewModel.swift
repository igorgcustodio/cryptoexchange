import Combine
import Models
import CoreUI
import Foundation

// MARK: - Protocols

@MainActor
public protocol MainViewModelCoordinatorDelegate: AnyObject {
    func showDetailsScreen(for exchange: Exchange)
}

@MainActor
public protocol MainViewModelProtocol: AnyObject {

    var events: PassthroughSubject<Void, Never> { get }
    var numberOfSections: Int { get }

    func numberOfItems(at section: Int) -> Int
    func item(at indexPath: IndexPath) -> MainTableViewDataRow

    func fetchExchanges() async throws
    func didSelectRow(at indexPath: IndexPath)
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
                    visible: true)
            )
            events.send()
        }
    }
    public var events = PassthroughSubject<Void, Never>()
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
            let exchanges = try await service.fetchExchanges()
            self.exchanges = exchanges
        } catch {
            print(error)
        }
    }

    public func didSelectRow(at indexPath: IndexPath) {
        coordinatorDelegate?.showDetailsScreen(for: exchanges[indexPath.row])
    }
}
