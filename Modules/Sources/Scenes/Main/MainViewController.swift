import CoreUI
import Combine
import UIKit

public final class MainViewController: LoadableViewController<MainView> {

    // MARK: - Properties

    private let viewModel: MainViewModelProtocol
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init

    public init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: - Lifecycle

    override public func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupBindings()
        Task {
            try await viewModel.fetchExchanges()
        }
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Methods

    private func setupBindings() {
        viewModel
            .events
            .receive(on: RunLoop.main)
            .sink { [weak self] in
                self?.contentView.tableView.reloadData()
            }
            .store(in: &cancellables)
    }

    private func setup() {
        setupUI()
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems(at: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.item(at: indexPath)

        switch item {
        case let .exchange(exchange):
            let cell: ExchangeTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(
                with: ExchangeTableViewCell.ViewData(
                    name: exchange.name ?? "N/A",
                    exchangeId: exchange.exchangeId ?? "N/A",
                    volume1day: exchange.volume1dayUsd ?? -1
                )
            )
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}

// MARK: - UIHelper

extension MainViewController: UIHelper {
    public func setupNavigationBar() {
        title = "Exchanges"
    }

    public func setupTableViews() {
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
}
