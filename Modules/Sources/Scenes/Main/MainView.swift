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

    private lazy var textField: UITextField = .buildTextField(placeholder: "Search")

    // MARK: - Properties

    // MARK: = Lifecycle

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
        addSubview(textField)
    }

    public func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8),

            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    public func configureViews() {
        tableView.register(ExchangeTableViewCell.self)
    }
}
