import Core
import Scenes
import UIKit

@MainActor
struct AppSetup {
    static func makeMainCoordinator(with navigationController: UINavigationController) -> MainCoordinator {
        let sceneFactory = SceneFactory(
            mainFactory: MainSeceneFactory(),
            exchangeDetailsFactory: ExchangeDetailsSceneFactory()
        )
        let mainCoordinator = MainCoordinator(navigationController: navigationController, sceneFactory: sceneFactory)
        return mainCoordinator
    }
}
