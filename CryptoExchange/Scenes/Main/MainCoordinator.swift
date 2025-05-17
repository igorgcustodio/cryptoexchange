import UIKit

@MainActor
final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    private let sceneFactory: SceneFactory

    init(
        navigationController: UINavigationController,
        sceneFactory: SceneFactory
    ) {
        self.navigationController = navigationController
        self.sceneFactory = sceneFactory
    }

    func start() {
        let viewController = sceneFactory.mainFactory.makeMainScene()
        handlePresentation(of: viewController, presentationStyle: .setRoot)
    }
}
