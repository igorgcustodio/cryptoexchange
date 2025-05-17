import UIKit

@MainActor
protocol MainSceneBuilding {
    func makeMainScene() -> UIViewController
}

@MainActor
final class MainSeceneFactory: MainSceneBuilding {

    func makeMainScene() -> UIViewController {
        let viewModel = MainViewModel()
        let viewController = MainViewController(viewModel: viewModel)
        return viewController
    }
}
