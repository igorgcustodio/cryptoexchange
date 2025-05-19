import UIKit

@MainActor
public protocol MainSceneBuilding {
    func makeMainScene(coordinatorDelegate: MainViewModelCoordinatorDelegate?) -> UIViewController
}

@MainActor
public final class MainSeceneFactory: MainSceneBuilding {

    public init() { }

    public func makeMainScene(coordinatorDelegate: MainViewModelCoordinatorDelegate?) -> UIViewController {
        let service = MainService()
        let viewModel = MainViewModel(service: service, coordinatorDelegate: coordinatorDelegate)
        let viewController = MainViewController(viewModel: viewModel)
        return viewController
    }
}
