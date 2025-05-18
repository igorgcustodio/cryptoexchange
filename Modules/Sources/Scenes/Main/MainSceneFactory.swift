import UIKit

@MainActor
public protocol MainSceneBuilding {
    func makeMainScene() -> UIViewController
}

@MainActor
public final class MainSeceneFactory: MainSceneBuilding {

    public init() { }

    public func makeMainScene() -> UIViewController {
        let service = MainService()
        let viewModel = MainViewModel(service: service)
        let viewController = MainViewController(viewModel: viewModel)
        return viewController
    }
}
