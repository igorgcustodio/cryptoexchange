import Core
import UIKit

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
        let viewController = sceneFactory.mainFactory.makeMainScene()
        handlePresentation(of: viewController, presentationStyle: .setRoot)
    }
}
