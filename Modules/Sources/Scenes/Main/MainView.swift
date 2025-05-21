import CoreUI
import DesignSystem
import UIKit

public final class MainView: UIView {
    // MARK: - UI Properties

    lazy var tableView: UITableView = .buildTableView(
        isScrollEnabled: true,
        style: .plain,
        allowsSelection: true
    )

    // MARK: - Lifecycle

    public init() {
        super.init(frame: .zero)
        setupViewCode()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewCodeConfiguration

extension MainView: ViewCodeConfiguration {
    public func setupViewHierarchy() {
        addSubview(tableView)
    }

    public func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    public func configureViews() {
        tableView.backgroundColor = .clear
        backgroundColor = UIColor.systemGroupedBackground
        tableView.register(ExchangeTableViewCell.self)
    }
}
