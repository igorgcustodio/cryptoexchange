import UIKit

final class MainViewController: LoadableViewController<MainView> {

    // MARK: - Properties
    private let viewModel: MainViewModelProtocol

    // MARK: - Init
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Methods

    private func setup() {
        setupUI()
    }
}

extension MainViewController: UIHelper {

}
