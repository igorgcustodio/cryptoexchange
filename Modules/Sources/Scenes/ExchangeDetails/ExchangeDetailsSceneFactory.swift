import Core
import UIKit
import Models

@MainActor
public protocol ExchangeDetailsSceneBuilding {
    func makeExchangeDetailsScene(
        exchange: Exchange,
        coordinatorDelegate: CoordinatorCommonDelegate?
    ) -> UIViewController
}

@MainActor
public final class ExchangeDetailsSceneFactory: ExchangeDetailsSceneBuilding {

    public init() {}

    public func makeExchangeDetailsScene(
        exchange: Exchange,
        coordinatorDelegate: CoordinatorCommonDelegate?
    ) -> UIViewController {
        let viewModel = ExchangeDetailsViewModel(exchange: exchange, coordinatorDelegte: coordinatorDelegate)
        return ExchangeDetailsViewController(viewModel: viewModel)
    }
}
