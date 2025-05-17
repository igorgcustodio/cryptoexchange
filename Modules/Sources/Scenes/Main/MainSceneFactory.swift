import UIKit

@MainActor
public protocol MainSceneBuilding {
    func makeMainScene() -> UIViewController
}

@MainActor
public final class MainSeceneFactory: MainSceneBuilding {

    public init() { }

    public func makeMainScene() -> UIViewController {
        let viewModel = MainViewModel()
        let viewController = MainViewController(viewModel: viewModel)
        return viewController
    }
}
