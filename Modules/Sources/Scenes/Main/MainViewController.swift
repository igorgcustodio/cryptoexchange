import CoreUI
import UIKit

public final class MainViewController: LoadableViewController<MainView> {

    // MARK: - Properties
    private let viewModel: MainViewModelProtocol

    // MARK: - Init
    public init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: - Lifecycle

    override public func viewDidLoad() {
        super.viewDidLoad()
        setup()
        Task {
            try await viewModel.fetchExchanges()
        }
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Methods

    private func setup() {
        setupUI()
    }
}

extension MainViewController: UIHelper {

}
