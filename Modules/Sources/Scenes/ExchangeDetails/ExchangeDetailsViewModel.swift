import Core
import Foundation
import Models

// MARK: - Protocols

@MainActor
public protocol ExchangeDetailsViewModelProtocol {
    var exchange: Exchange { get }
}

// MARK: - View Model

@MainActor
public final class ExchangeDetailsViewModel {
    // MARK: - Properties

    public private(set) var exchange: Exchange
    private weak var coordinatorDelegte: CoordinatorCommonDelegate?

    // MARK: - Lifecycle

    init(exchange: Exchange, coordinatorDelegte: CoordinatorCommonDelegate?) {
        self.exchange = exchange
        self.coordinatorDelegte = coordinatorDelegte
    }
}

// MARK: - ExchangeDetailsViewModelProtocol

extension ExchangeDetailsViewModel: ExchangeDetailsViewModelProtocol { }
