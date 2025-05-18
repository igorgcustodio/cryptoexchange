import CoreUI
import DesignSystem
import UIKit

public final class MainView: UIView {

    // MARK: - UI Properties
    private lazy var tableView: UITableView = .buildTableView(
        isScrollEnabled: true,
        style: .plain,
        allowsSelection: true
    )

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

    }

    public func setupConstraints() {

    }

    public func configureViews() {

    }
}
