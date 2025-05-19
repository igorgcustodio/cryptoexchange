import Foundation
import Core

// MARK: - Protocols

@MainActor
public protocol ExchangeDetailsViewModelProtocol {

}

// MARK: - View Model

@MainActor
public final class ExchangeDetailsViewModel {

    private weak var coordinatorDelegte: CoordinatorCommonDelegate?

    init(coordinatorDelegte: CoordinatorCommonDelegate?) {
        self.coordinatorDelegte = coordinatorDelegte
    }
}

extension ExchangeDetailsViewModel: ExchangeDetailsViewModelProtocol {

}
