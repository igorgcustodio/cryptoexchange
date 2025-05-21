import Core
import CoreUI
import DesignSystem
import UIKit

public final class ExchangeDetailsView: UIView {

    // MARK: - UI Properties

    public private(set) lazy var nameLabel: UILabel = {
        let label = CustomLabel(color: .label, numberOfLines: 0)
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()

    public private(set) lazy var exchangeIdLabel: UILabel = {
        let label = CustomLabel(color: .secondaryLabel)
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()

    public private(set) lazy var metadataSection: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 12
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return stack
    }()

    public private(set) lazy var volumeSection: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 12
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return stack
    }()

    public private(set) lazy var headerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, exchangeIdLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        return stack
    }()

    public private(set) lazy var containerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [headerStack, metadataSection, volumeSection])
        stack.axis = .vertical
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    public private(set) lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerStack)
        return view
    }()

    public private(set) lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(contentView)
        return scroll
    }()

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func setupSection(_ stack: UIStackView, title: String) {
        let titleLabel = makeLabel(text: title, font: .boldSystemFont(ofSize: 17), color: .label)
        stack.addArrangedSubview(titleLabel)
    }

    public func addRow(to section: UIStackView, icon: UIImage?, title: String, value: String?) {
        guard let value = value else { return }

        let iconView = makeIconView(image: icon)
        let titleLabel = makeLabel(
            text: title.uppercased(),
            font: .systemFont(ofSize: 14, weight: .semibold),
            color: .label
        )
        let valueLabel = makeLabel(text: value, font: .systemFont(ofSize: 15), color: .darkGray)
        valueLabel.numberOfLines = 0

        let labelsStack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        labelsStack.axis = .vertical
        labelsStack.spacing = 2

        let row = UIStackView(arrangedSubviews: [iconView, labelsStack])
        row.axis = .horizontal
        row.spacing = 12
        row.alignment = .top

        section.addArrangedSubview(row)
    }

    public func addFormattedDateRow(to section: UIStackView, icon: UIImage?, title: String, isoDate: String?) {
        guard
            let isoDate,
            let date = DateFormatter.customDateFormatter.date(from: isoDate)
        else { return }

        addRow(to: section, icon: icon, title: title, value: date.formatted())
    }

    // MARK: - Helpers

    private func makeLabel(text: String, font: UIFont, color: UIColor) -> UILabel {
        let label = CustomLabel(color: color)
        label.font = font
        label.text = text
        return label
    }

    private func makeIconView(image: UIImage?) -> UIImageView {
        let iconView = UIImageView(image: image)
        iconView.tintColor = .gray
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 20),
            iconView.heightAnchor.constraint(equalToConstant: 20)
        ])
        return iconView
    }
}

// MARK: - ViewCodeConfiguration

extension ExchangeDetailsView: ViewCodeConfiguration {

    public func setupViewHierarchy() {
        addSubview(scrollView)
    }

    public func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            containerStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            containerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }

    public func configureViews() {
        backgroundColor = .systemGroupedBackground

        setupSection(metadataSection, title: "Metadata")
        setupSection(volumeSection, title: "Volume")
    }
}
