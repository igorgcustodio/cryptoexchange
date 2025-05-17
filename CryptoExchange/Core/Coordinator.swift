import UIKit

@MainActor
public protocol Coordinator: AnyObject {

    // MARK: - Properties

    var navigationController: UINavigationController? { get set }

    // MARK: - Methods

    func start()
    func handlePresentation(
        of viewController: UIViewController,
        from presentingViewController: UIViewController?,
        presentationStyle: PresentationStyle
    )
}

public enum PresentationStyle {
    case push
    case present
    case setRoot
}

extension Coordinator {
    public func handlePresentation(
        of viewController: UIViewController,
        from presentingViewController: UIViewController? = nil,
        presentationStyle: PresentationStyle
    ) {
        switch presentationStyle {
        case .push:
            if let navigation = (presentingViewController as? UINavigationController) ?? navigationController {
                navigation.pushViewController(viewController, animated: true)
            } else {
                assertionFailure("No UINavigationController available for push presentation")
            }
        case .present:
            if let presenting = presentingViewController ??
                navigationController?.topViewController ??
                navigationController?.presentedViewController {
                presenting.present(viewController, animated: true)
            } else {
                assertionFailure("No presenting view controller available for present the view controller")
            }
        case .setRoot:
            let navigation = navigationController ?? UINavigationController()
            navigation.setViewControllers([viewController], animated: false)
            navigationController = navigation
        }
    }
}

protocol CoordinatorCommonDelegate: AnyObject {
    func backTapped()
    func closeTapped()
}

extension CoordinatorCommonDelegate {
    func backTapped() {}
    func closeTapped() {}
}
