import Core
import Foundation
import Models

// MARK: - Protocols

@MainActor
public protocol ExchangeDetailsViewModelProtocol { }

// MARK: - View Model

@MainActor
public final class ExchangeDetailsViewModel {
    private let exchange: Exchange
    private weak var coordinatorDelegte: CoordinatorCommonDelegate?

    init(exchange: Exchange, coordinatorDelegte: CoordinatorCommonDelegate?) {
        self.exchange = exchange
        self.coordinatorDelegte = coordinatorDelegte
    }
}

extension ExchangeDetailsViewModel: ExchangeDetailsViewModelProtocol { }
