import CoreUI
import DesignSystem
import UIKit

final class ExchangeTableViewCell: UITableViewCell, ReusableIdentifier {
    // MARK: - View Data

    struct ViewData {
        let name: String
        let exchangeId: String
        let volume1day: Double
    }

    // MARK: - UI Properties

    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.cornerRadius(with: 12)
        view.addShadow(
            opacity: 0.05,
            offset: CGSize(width: 0, height: 2),
            radius: 4
        )
        return view
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .label
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var exchangeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var volumeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .tertiaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setupViewCode()
    }

    @available(*, unavailable)
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Reuse

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        exchangeLabel.text = nil
        volumeLabel.text = nil
    }

    // MARK: - Setup

    func setup(with viewData: ViewData) {
        nameLabel.text = viewData.name
        exchangeLabel.text = "Exchange ID: \(viewData.exchangeId)"
        volumeLabel.text = "Volume 1d: \(String(format: "%.2f", viewData.volume1day))"
    }
}

// MARK: - ViewCode

extension ExchangeTableViewCell: ViewCodeConfiguration {
    func setupViewHierarchy() {
        contentView.addSubview(container)
        container.addSubviews([nameLabel, exchangeLabel, volumeLabel])
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            nameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),

            exchangeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            exchangeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            exchangeLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

            volumeLabel.topAnchor.constraint(equalTo: exchangeLabel.bottomAnchor, constant: 4),
            volumeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            volumeLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            volumeLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12),
        ])
    }

    func configureViews() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
}
