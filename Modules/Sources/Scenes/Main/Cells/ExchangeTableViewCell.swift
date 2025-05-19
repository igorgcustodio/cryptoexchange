import DesignSystem
import CoreUI
import UIKit

final class ExchangeTableViewCell: UITableViewCell, ReusableIdentifier {

    // MARK: - View Data

    struct ViewData {
        let name: String
        let exchangeId: String
        let volume1day: Double
    }

    // MARK: - UI Properties

    private lazy var container: UIView = .emptyView
    private lazy var nameLabel: UILabel = .buildLabel(color: .black)
    private lazy var volumeLabel: UILabel = .buildLabel(color: .black)
    private lazy var exchangeLabel: UILabel = .buildLabel(color: .black)

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewCode()
    }

    @available(*, unavailable)
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        exchangeLabel.text = nil
        volumeLabel.text = nil
    }

    func setup(with viewData: ViewData) {
        nameLabel.text = viewData.name
        volumeLabel.text = "Volume 1 day: \(viewData.volume1day)"
        exchangeLabel.text = "Exchange ID: \(viewData.exchangeId)"
    }
}

extension ExchangeTableViewCell: ViewCodeConfiguration {
    func setupViewHierarchy() {
        contentView.addSubview(container)
        container.addSubviews([
            nameLabel, volumeLabel, exchangeLabel
        ])
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),

            exchangeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            exchangeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            exchangeLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

            volumeLabel.topAnchor.constraint(equalTo: exchangeLabel.bottomAnchor, constant: 4),
            volumeLabel.leadingAnchor.constraint(equalTo: exchangeLabel.leadingAnchor),
            volumeLabel.trailingAnchor.constraint(equalTo: exchangeLabel.trailingAnchor),
            volumeLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8),
        ])
    }

    func configureViews() {

    }
}
