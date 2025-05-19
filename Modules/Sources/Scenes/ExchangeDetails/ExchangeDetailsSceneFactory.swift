import Core
import UIKit

@MainActor
public protocol ExchangeDetailsSceneBuilding {
    func makeExchangeDetailsScene(coordinatorDelegate: CoordinatorCommonDelegate?) -> UIViewController
}

@MainActor
public final class ExchangeDetailsSceneFactory: ExchangeDetailsSceneBuilding {
    public init() {}

    public func makeExchangeDetailsScene(coordinatorDelegate: CoordinatorCommonDelegate?) -> UIViewController {
        let viewModel = ExchangeDetailsViewModel(coordinatorDelegte: coordinatorDelegate)
        return ExchangeDetailsViewController(viewModel: viewModel)
    }
}
