import Core
import UIKit
import Models

@MainActor
public final class MainCoordinator: Coordinator {

    public var navigationController: UINavigationController?
    private let sceneFactory: SceneFactory

    public init(
        navigationController: UINavigationController,
        sceneFactory: SceneFactory
    ) {
        self.navigationController = navigationController
        self.sceneFactory = sceneFactory
    }

    public func start() {
        let viewController = sceneFactory.mainFactory.makeMainScene(coordinatorDelegate: self)
        handlePresentation(of: viewController, presentationStyle: .setRoot)
    }
}

extension MainCoordinator: MainViewModelCoordinatorDelegate {
    public func showDetailsScreen(for exchange: Exchange) {
        let viewController = sceneFactory.exchangeDetailsFactory.makeExchangeDetailsScene(coordinatorDelegate: self)
        handlePresentation(of: viewController, presentationStyle: .push)
    }
}

extension MainCoordinator: CoordinatorCommonDelegate {
    public func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}
